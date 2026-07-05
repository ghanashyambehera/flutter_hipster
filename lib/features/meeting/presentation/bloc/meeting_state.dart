import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/connection_status.dart';
import '../../domain/entities/meeting_event.dart';
import '../../domain/entities/meeting_session.dart';

/// Base for all meeting states. The append-only [log] travels with every state
/// so the UI stays a pure function of state (constitution Articles II & V).
sealed class MeetingState extends Equatable {
  const MeetingState({required this.log});

  final List<MeetingEvent> log;

  ConnectionStatus get status;

  @override
  List<Object?> get props => [status, log];
}

/// No active meeting. Shown on the Home screen.
class MeetingIdle extends MeetingState {
  const MeetingIdle({super.log = const []});

  @override
  ConnectionStatus get status => ConnectionStatus.idle;
}

/// A create/join request is in flight (from the API call until the SDK confirms
/// connection). Never reaches `connected` on the HTTP response alone.
class MeetingJoining extends MeetingState {
  const MeetingJoining({required this.role, required super.log, this.meetingId});

  final MeetingRole role;
  final String? meetingId;

  @override
  ConnectionStatus get status => ConnectionStatus.joining;

  @override
  List<Object?> get props => [status, log, role, meetingId];
}

/// Live call. Tile ids and control flags drive the UI.
class MeetingConnected extends MeetingState {
  const MeetingConnected({
    required this.session,
    required super.log,
    this.localTileId,
    this.remoteTileId,
    this.remotePresent = false,
    this.micOn = true,
    this.cameraOn = true,
    this.frontCamera = true,
  });

  final MeetingSession session;
  final int? localTileId;
  final int? remoteTileId;
  final bool remotePresent;
  final bool micOn;
  final bool cameraOn;
  final bool frontCamera;

  @override
  ConnectionStatus get status => ConnectionStatus.connected;

  MeetingConnected copyWith({
    int? localTileId,
    bool clearLocalTile = false,
    int? remoteTileId,
    bool clearRemoteTile = false,
    bool? remotePresent,
    bool? micOn,
    bool? cameraOn,
    bool? frontCamera,
    List<MeetingEvent>? log,
  }) {
    return MeetingConnected(
      session: session,
      localTileId: clearLocalTile ? null : (localTileId ?? this.localTileId),
      remoteTileId: clearRemoteTile ? null : (remoteTileId ?? this.remoteTileId),
      remotePresent: remotePresent ?? this.remotePresent,
      micOn: micOn ?? this.micOn,
      cameraOn: cameraOn ?? this.cameraOn,
      frontCamera: frontCamera ?? this.frontCamera,
      log: log ?? this.log,
    );
  }

  @override
  List<Object?> get props => [
        status,
        log,
        session,
        localTileId,
        remoteTileId,
        remotePresent,
        micOn,
        cameraOn,
        frontCamera,
      ];
}

/// The session ended (locally or via the SDK). Returns the user to Home.
class MeetingDisconnected extends MeetingState {
  const MeetingDisconnected({required super.log, this.reason});

  final String? reason;

  @override
  ConnectionStatus get status => ConnectionStatus.disconnected;

  @override
  List<Object?> get props => [status, log, reason];
}

/// A typed failure surfaced to the user. Carries the [failure] for a snackbar
/// and preserves the [log] (which already contains the matching error entry).
class MeetingErrorState extends MeetingState {
  const MeetingErrorState({required this.failure, required super.log});

  final Failure failure;

  @override
  ConnectionStatus get status => ConnectionStatus.error;

  @override
  List<Object?> get props => [status, log, failure];
}
