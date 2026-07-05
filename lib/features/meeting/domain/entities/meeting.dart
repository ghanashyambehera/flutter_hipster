import 'package:equatable/equatable.dart';

/// A Chime meeting. [rawMeetingJson] preserves the exact backend payload so the
/// native bridge can rebuild Chime's `CreateMeetingResponse` without loss.
class Meeting extends Equatable {
  const Meeting({
    required this.meetingId,
    required this.rawMeetingJson,
    this.externalMeetingId,
    this.mediaRegion,
  });

  final String meetingId;
  final String? externalMeetingId;
  final String? mediaRegion;
  final Map<String, dynamic> rawMeetingJson;

  @override
  List<Object?> get props => [meetingId, externalMeetingId, mediaRegion];
}
