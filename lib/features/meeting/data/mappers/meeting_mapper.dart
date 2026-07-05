import '../../domain/entities/attendee.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_session.dart';
import '../models/meeting_dtos.dart';

/// Maps data-layer DTOs to domain entities. The raw JSON is retained (via
/// `toJson`) so the native Chime bridge receives the exact SDK-shaped payload.
extension ChimeMeetingDtoMapper on ChimeMeetingDto {
  Meeting toEntity() => Meeting(
        meetingId: meetingId,
        externalMeetingId: externalMeetingId,
        mediaRegion: mediaRegion,
        rawMeetingJson: toJson(),
      );
}

extension ChimeAttendeeDtoMapper on ChimeAttendeeDto {
  Attendee toEntity() => Attendee(
        attendeeId: attendeeId,
        externalUserId: externalUserId,
        joinToken: joinToken,
        rawAttendeeJson: toJson(),
      );
}

extension MeetingDataDtoMapper on MeetingDataDto {
  MeetingSession toSession(MeetingRole role) => MeetingSession(
        meeting: meeting.toEntity(),
        attendee: attendee.toEntity(),
        role: role,
      );
}
