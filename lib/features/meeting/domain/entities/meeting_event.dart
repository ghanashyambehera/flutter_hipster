import 'package:equatable/equatable.dart';

/// Typed category for a single append-only event-log entry.
enum MeetingEventType {
  meetingStarted,
  meetingEnded,
  participantJoined,
  participantLeft,
  micOn,
  micOff,
  cameraOn,
  cameraOff,
  error,
}

/// One immutable, timestamped audit-trail record. The event log is the
/// observability backbone of a session (constitution Article V).
class MeetingEvent extends Equatable {
  const MeetingEvent({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.message,
  });

  final String id;
  final DateTime timestamp;
  final MeetingEventType type;
  final String message;

  @override
  List<Object?> get props => [id, timestamp, type, message];
}
