import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/entities/meeting_event.dart';
import '../../domain/entities/meeting_session.dart';
import '../../domain/ports/permission_service.dart';
import '../../domain/ports/rtc_client.dart';
import '../../domain/ports/rtc_event.dart';
import '../../domain/usecases/create_meeting.dart';
import '../../domain/usecases/join_meeting.dart';
import 'meeting_state.dart';
import 'meeting_ui_event.dart';

/// The single source of truth for meeting lifecycle, controls, and the event
/// log. UI is a pure function of the emitted [MeetingState]; all side effects
/// (API, RTC, permissions) go through injected use cases/ports.
class MeetingBloc extends Bloc<MeetingUiEvent, MeetingState> {
  MeetingBloc({
    required CreateMeeting createMeeting,
    required JoinMeeting joinMeeting,
    required RtcClient rtcClient,
    required PermissionService permissionService,
    AppLogger logger = const AppLogger(),
  })  : _createMeeting = createMeeting,
        _joinMeeting = joinMeeting,
        _rtc = rtcClient,
        _permissions = permissionService,
        _logger = logger,
        super(const MeetingIdle()) {
    on<CreateMeetingRequested>(_onCreate);
    on<JoinMeetingRequested>(_onJoin);
    on<MicToggled>(_onMicToggled);
    on<CameraToggled>(_onCameraToggled);
    on<CameraSwitched>(_onCameraSwitched);
    on<LeaveRequested>(_onLeave);
    on<MeetingReset>(_onReset);
    on<OpenAppSettingsRequested>(_onOpenSettings);
    on<RtcEventReceived>(_onRtcEvent);

    _rtcSub = _rtc.events.listen((e) => add(RtcEventReceived(e)));
  }

  final CreateMeeting _createMeeting;
  final JoinMeeting _joinMeeting;
  final RtcClient _rtc;
  final PermissionService _permissions;
  final AppLogger _logger;

  late final StreamSubscription<RtcEvent> _rtcSub;

  final List<MeetingEvent> _log = [];
  int _logSeq = 0;
  MeetingSession? _currentSession;

  // ----- Event log helpers -------------------------------------------------

  List<MeetingEvent> _append(MeetingEventType type, String message) {
    _log.add(MeetingEvent(
      id: '${DateTime.now().microsecondsSinceEpoch}-${_logSeq++}',
      timestamp: DateTime.now(),
      type: type,
      message: message,
    ));
    return List<MeetingEvent>.unmodifiable(_log);
  }

  List<MeetingEvent> get _snapshot => List<MeetingEvent>.unmodifiable(_log);

  // ----- Create / Join -----------------------------------------------------

  Future<void> _onCreate(
    CreateMeetingRequested event,
    Emitter<MeetingState> emit,
  ) async {
    _resetLog();
    emit(MeetingJoining(role: MeetingRole.agent, log: _snapshot));
    final result = await _createMeeting();
    await result.fold(
      (failure) async => _emitFailure(failure, emit),
      (session) async => _connect(session, emit),
    );
  }

  Future<void> _onJoin(
    JoinMeetingRequested event,
    Emitter<MeetingState> emit,
  ) async {
    _resetLog();
    emit(MeetingJoining(
      role: MeetingRole.client,
      log: _snapshot,
      meetingId: event.meetingId.trim(),
    ));
    final result = await _joinMeeting(event.meetingId);
    await result.fold(
      (failure) async => _emitFailure(failure, emit),
      (session) async => _connect(session, emit),
    );
  }

  Future<void> _connect(MeetingSession session, Emitter<MeetingState> emit) async {
    final granted = await _permissions.ensureCameraAndMic();
    if (!granted) {
      _emitFailure(const PermissionFailure(), emit);
      return;
    }
    _currentSession = session;
    try {
      await _rtc.start(session);
      // Stay in `Joining`; the SDK's `connected` callback drives `Connected`.
    } catch (e) {
      _logger.error('RTC start failed', e);
      _emitFailure(RtcFailure(e.toString()), emit);
    }
  }

  // ----- Controls ----------------------------------------------------------

  Future<void> _onMicToggled(MicToggled event, Emitter<MeetingState> emit) async {
    final s = state;
    if (s is! MeetingConnected) return;
    final newMicOn = !s.micOn;
    try {
      await _rtc.setMuted(!newMicOn);
      final log = _append(
        newMicOn ? MeetingEventType.micOn : MeetingEventType.micOff,
        newMicOn ? 'Microphone on' : 'Microphone off',
      );
      emit(s.copyWith(micOn: newMicOn, log: log));
    } catch (e) {
      _emitInlineError(RtcFailure(e.toString()), emit);
    }
  }

  Future<void> _onCameraToggled(
    CameraToggled event,
    Emitter<MeetingState> emit,
  ) async {
    final s = state;
    if (s is! MeetingConnected) return;
    final newCamOn = !s.cameraOn;
    try {
      await _rtc.setCameraEnabled(newCamOn);
      final log = _append(
        newCamOn ? MeetingEventType.cameraOn : MeetingEventType.cameraOff,
        newCamOn ? 'Camera on' : 'Camera off',
      );
      // Tile add/remove arrives via RTC events; reflect the flag immediately.
      emit(s.copyWith(cameraOn: newCamOn, log: log));
    } catch (e) {
      _emitInlineError(RtcFailure(e.toString()), emit);
    }
  }

  Future<void> _onCameraSwitched(
    CameraSwitched event,
    Emitter<MeetingState> emit,
  ) async {
    final s = state;
    if (s is! MeetingConnected) return;
    try {
      await _rtc.switchCamera();
      emit(s.copyWith(frontCamera: !s.frontCamera));
    } catch (e) {
      _emitInlineError(RtcFailure(e.toString()), emit);
    }
  }

  Future<void> _onLeave(LeaveRequested event, Emitter<MeetingState> emit) async {
    try {
      await _rtc.stop();
      // `disconnected` callback finalizes the transition + `meetingEnded` log.
    } catch (e) {
      _logger.error('RTC stop failed', e);
      final log = _append(MeetingEventType.meetingEnded, 'Left the meeting');
      emit(MeetingDisconnected(log: log, reason: 'left'));
      _currentSession = null;
    }
  }

  void _onReset(MeetingReset event, Emitter<MeetingState> emit) {
    _resetLog();
    _currentSession = null;
    emit(const MeetingIdle());
  }

  Future<void> _onOpenSettings(
    OpenAppSettingsRequested event,
    Emitter<MeetingState> emit,
  ) async {
    await _permissions.openSettings();
  }

  // ----- RTC events --------------------------------------------------------

  void _onRtcEvent(RtcEventReceived event, Emitter<MeetingState> emit) {
    final rtc = event.event;
    switch (rtc) {
      case RtcConnected():
        final session = _currentSession;
        if (session == null) return;
        final log = _append(MeetingEventType.meetingStarted, 'Meeting started');
        emit(MeetingConnected(session: session, log: log));
      case RtcDisconnected(:final reason):
        final log = _append(MeetingEventType.meetingEnded, 'Meeting ended');
        _currentSession = null;
        emit(MeetingDisconnected(log: log, reason: reason));
      case RtcAttendeeJoined(:final attendeeId):
        final log = _append(
          MeetingEventType.participantJoined,
          'Participant joined ($attendeeId)',
        );
        final s = state;
        emit(s is MeetingConnected
            ? s.copyWith(remotePresent: true, log: log)
            : s);
      case RtcAttendeeLeft(:final attendeeId):
        final log = _append(
          MeetingEventType.participantLeft,
          'Participant left ($attendeeId)',
        );
        final s = state;
        emit(s is MeetingConnected
            ? s.copyWith(remotePresent: false, clearRemoteTile: true, log: log)
            : s);
      case RtcVideoTileAdded(:final tileId, :final isLocal):
        final s = state;
        if (s is! MeetingConnected) return;
        emit(isLocal
            ? s.copyWith(localTileId: tileId)
            : s.copyWith(remoteTileId: tileId, remotePresent: true));
      case RtcVideoTileRemoved(:final tileId):
        final s = state;
        if (s is! MeetingConnected) return;
        if (s.localTileId == tileId) {
          emit(s.copyWith(clearLocalTile: true));
        } else if (s.remoteTileId == tileId) {
          emit(s.copyWith(clearRemoteTile: true));
        }
      case RtcError(:final message):
        _emitInlineError(RtcFailure(message), emit);
    }
  }

  // ----- Failure helpers ---------------------------------------------------

  /// Terminal failure (before/instead of connecting): logs + error state.
  void _emitFailure(Failure failure, Emitter<MeetingState> emit) {
    _logger.warn('Meeting failure: ${failure.message}');
    final log = _append(MeetingEventType.error, failure.message);
    emit(MeetingErrorState(failure: failure, log: log));
  }

  /// Non-fatal error while connected: log it and keep the call alive so the UI
  /// simply reflects the new log entry.
  void _emitInlineError(Failure failure, Emitter<MeetingState> emit) {
    final log = _append(MeetingEventType.error, failure.message);
    final s = state;
    if (s is MeetingConnected) {
      emit(s.copyWith(log: log));
    } else {
      emit(MeetingErrorState(failure: failure, log: log));
    }
  }

  void _resetLog() {
    _log.clear();
    _logSeq = 0;
  }

  @override
  Future<void> close() async {
    await _rtcSub.cancel();
    return super.close();
  }
}
