import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/meeting.dart';
import '../entities/meeting_session.dart';

/// Abstraction over the meetings backend. Implemented in the data layer.
/// Every method returns a typed [Failure] on the left or a [MeetingSession] on
/// the right — no exceptions leak out (constitution Article III).
abstract class MeetingRepository {
  /// Creates a new meeting as the Host (`type=agent`, no meeting id).
  Future<Either<Failure, MeetingSession>> createMeeting();

  /// Joins an existing meeting as the Guest. [meeting] is the full meeting
  /// object (with `MediaPlacement`) shared by the host; the backend only issues
  /// a fresh attendee token for joiners, so the media URLs must come from here.
  Future<Either<Failure, MeetingSession>> joinAsClient(Meeting meeting);

  /// Re-issues an agent attendee for an existing meeting (`type=agent` + id).
  Future<Either<Failure, MeetingSession>> refreshAgent(String meetingId);
}
