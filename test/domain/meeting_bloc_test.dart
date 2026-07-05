import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meeting_app/core/error/failures.dart';
import 'package:meeting_app/features/meeting/domain/entities/meeting.dart';
import 'package:meeting_app/features/meeting/domain/entities/attendee.dart';
import 'package:meeting_app/features/meeting/domain/entities/meeting_event.dart';
import 'package:meeting_app/features/meeting/domain/entities/meeting_session.dart';
import 'package:meeting_app/features/meeting/domain/ports/meeting_repository.dart';
import 'package:meeting_app/features/meeting/domain/ports/permission_service.dart';
import 'package:meeting_app/features/meeting/domain/ports/rtc_client.dart';
import 'package:meeting_app/features/meeting/domain/ports/rtc_event.dart';
import 'package:meeting_app/features/meeting/domain/usecases/create_meeting.dart';
import 'package:meeting_app/features/meeting/domain/usecases/join_meeting.dart';
import 'package:meeting_app/features/meeting/presentation/bloc/meeting_bloc.dart';
import 'package:meeting_app/features/meeting/presentation/bloc/meeting_state.dart';
import 'package:meeting_app/features/meeting/presentation/bloc/meeting_ui_event.dart';

/// Repository stub whose result is configurable per test.
class _StubRepository implements MeetingRepository {
  _StubRepository(this.result);
  Either<Failure, MeetingSession> result;

  @override
  Future<Either<Failure, MeetingSession>> createMeeting() async => result;

  @override
  Future<Either<Failure, MeetingSession>> joinAsClient(Meeting meeting) async =>
      result;

  @override
  Future<Either<Failure, MeetingSession>> refreshAgent(String meetingId) async =>
      result;
}

/// RTC client that records commands and lets the test drive events.
class _ControllableRtc implements RtcClient {
  final StreamController<RtcEvent> _controller =
      StreamController<RtcEvent>.broadcast();
  final List<String> calls = [];

  void emit(RtcEvent e) => _controller.add(e);

  @override
  Stream<RtcEvent> get events => _controller.stream;

  @override
  Future<void> start(MeetingSession session) async => calls.add('start');
  @override
  Future<void> stop() async => calls.add('stop');
  @override
  Future<void> setMuted(bool muted) async => calls.add('setMuted:$muted');
  @override
  Future<void> setCameraEnabled(bool enabled) async =>
      calls.add('setCameraEnabled:$enabled');
  @override
  Future<void> switchCamera() async => calls.add('switchCamera');
}

class _FakePermissions implements PermissionService {
  _FakePermissions(this.granted);
  final bool granted;
  @override
  Future<bool> ensureCameraAndMic() async => granted;
  @override
  Future<bool> openSettings() async => true;
}

MeetingSession _session() => const MeetingSession(
      meeting: Meeting(meetingId: 'm-1', rawMeetingJson: {}),
      attendee: Attendee(
        attendeeId: 'a-1',
        externalUserId: 'u-1',
        joinToken: 't-1',
        rawAttendeeJson: {},
      ),
      role: MeetingRole.agent,
    );

void main() {
  late _StubRepository repo;
  late _ControllableRtc rtc;

  MeetingBloc build({bool granted = true}) => MeetingBloc(
        createMeeting: CreateMeeting(repo),
        joinMeeting: JoinMeeting(repo),
        rtcClient: rtc,
        permissionService: _FakePermissions(granted),
      );

  setUp(() {
    repo = _StubRepository(Right(_session()));
    rtc = _ControllableRtc();
  });

  List<MeetingEventType> logTypes(MeetingState s) =>
      s.log.map((e) => e.type).toList();

  group('create → connect happy path', () {
    blocTest<MeetingBloc, MeetingState>(
      'goes Idle → Joining → Connected once the SDK confirms, and logs start',
      build: build,
      act: (bloc) async {
        bloc.add(const CreateMeetingRequested());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        rtc.emit(const RtcConnected());
      },
      wait: const Duration(milliseconds: 30),
      expect: () => [
        isA<MeetingJoining>(),
        isA<MeetingConnected>(),
      ],
      verify: (bloc) {
        expect(rtc.calls, contains('start'));
        final connected = bloc.state as MeetingConnected;
        expect(logTypes(connected), contains(MeetingEventType.meetingStarted));
        expect(connected.micOn, isTrue);
        expect(connected.cameraOn, isTrue);
      },
    );

    blocTest<MeetingBloc, MeetingState>(
      'does NOT reach Connected on the API response alone',
      build: build,
      act: (bloc) => bloc.add(const CreateMeetingRequested()),
      wait: const Duration(milliseconds: 30),
      verify: (bloc) => expect(bloc.state, isA<MeetingJoining>()),
    );
  });

  group('failures surface as errors + log entry', () {
    blocTest<MeetingBloc, MeetingState>(
      'create failure → MeetingErrorState with an error log entry',
      build: () {
        repo = _StubRepository(const Left(ServerFailure('down', statusCode: 500)));
        return build();
      },
      act: (bloc) => bloc.add(const CreateMeetingRequested()),
      wait: const Duration(milliseconds: 30),
      expect: () => [isA<MeetingJoining>(), isA<MeetingErrorState>()],
      verify: (bloc) => expect(
        logTypes(bloc.state),
        contains(MeetingEventType.error),
      ),
    );

    blocTest<MeetingBloc, MeetingState>(
      'permission denied → PermissionFailure, RTC never started',
      build: () => build(granted: false),
      act: (bloc) => bloc.add(const CreateMeetingRequested()),
      wait: const Duration(milliseconds: 30),
      verify: (bloc) {
        expect(bloc.state, isA<MeetingErrorState>());
        expect((bloc.state as MeetingErrorState).failure, isA<PermissionFailure>());
        expect(rtc.calls, isNot(contains('start')));
      },
    );
  });

  group('controls emit exactly one log entry each', () {
    blocTest<MeetingBloc, MeetingState>(
      'mic toggle mutes and logs micOff',
      build: build,
      act: (bloc) async {
        bloc.add(const CreateMeetingRequested());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        rtc.emit(const RtcConnected());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(const MicToggled());
      },
      wait: const Duration(milliseconds: 40),
      verify: (bloc) {
        expect(rtc.calls, contains('setMuted:true'));
        final s = bloc.state as MeetingConnected;
        expect(s.micOn, isFalse);
        expect(
          logTypes(s).where((t) => t == MeetingEventType.micOff).length,
          1,
        );
      },
    );
  });

  group('remote participant lifecycle', () {
    blocTest<MeetingBloc, MeetingState>(
      'attendee left logs participantLeft and clears remote tile',
      build: build,
      act: (bloc) async {
        bloc.add(const CreateMeetingRequested());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        rtc.emit(const RtcConnected());
        rtc.emit(const RtcVideoTileAdded(tileId: 2, isLocal: false));
        await Future<void>.delayed(const Duration(milliseconds: 10));
        rtc.emit(const RtcAttendeeLeft('remote'));
      },
      wait: const Duration(milliseconds: 40),
      verify: (bloc) {
        final s = bloc.state as MeetingConnected;
        expect(s.remotePresent, isFalse);
        expect(s.remoteTileId, isNull);
        expect(logTypes(s), contains(MeetingEventType.participantLeft));
      },
    );
  });

  group('leave', () {
    blocTest<MeetingBloc, MeetingState>(
      'leave stops RTC and disconnected callback ends the meeting',
      build: build,
      act: (bloc) async {
        bloc.add(const CreateMeetingRequested());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        rtc.emit(const RtcConnected());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        bloc.add(const LeaveRequested());
        await Future<void>.delayed(const Duration(milliseconds: 10));
        rtc.emit(const RtcDisconnected('left'));
      },
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(rtc.calls, contains('stop'));
        expect(bloc.state, isA<MeetingDisconnected>());
        expect(logTypes(bloc.state), contains(MeetingEventType.meetingEnded));
      },
    );
  });
}
