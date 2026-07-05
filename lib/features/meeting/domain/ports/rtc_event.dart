import 'package:equatable/equatable.dart';

/// Events emitted by an [RtcClient]. Chime SDK observer callbacks are mapped to
/// these transport-agnostic variants so the domain/bloc never sees SDK types.
sealed class RtcEvent extends Equatable {
  const RtcEvent();

  @override
  List<Object?> get props => [];
}

/// Audio/video session started — the source of truth for `Connected`.
class RtcConnected extends RtcEvent {
  const RtcConnected();
}

/// Audio/video session stopped — the source of truth for `Disconnected`.
class RtcDisconnected extends RtcEvent {
  const RtcDisconnected([this.reason]);

  final String? reason;

  @override
  List<Object?> get props => [reason];
}

class RtcAttendeeJoined extends RtcEvent {
  const RtcAttendeeJoined(this.attendeeId);

  final String attendeeId;

  @override
  List<Object?> get props => [attendeeId];
}

class RtcAttendeeLeft extends RtcEvent {
  const RtcAttendeeLeft(this.attendeeId);

  final String attendeeId;

  @override
  List<Object?> get props => [attendeeId];
}

class RtcVideoTileAdded extends RtcEvent {
  const RtcVideoTileAdded({
    required this.tileId,
    required this.isLocal,
    this.attendeeId,
  });

  final int tileId;
  final bool isLocal;
  final String? attendeeId;

  @override
  List<Object?> get props => [tileId, isLocal, attendeeId];
}

class RtcVideoTileRemoved extends RtcEvent {
  const RtcVideoTileRemoved(this.tileId);

  final int tileId;

  @override
  List<Object?> get props => [tileId];
}

class RtcError extends RtcEvent {
  const RtcError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
