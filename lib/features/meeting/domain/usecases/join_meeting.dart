import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/invite_codec.dart';
import '../entities/meeting.dart';
import '../entities/meeting_session.dart';
import '../ports/meeting_repository.dart';

/// Joins an existing meeting as the Guest.
///
/// The [inviteCode] carries the full meeting object shared by the host (the
/// backend does not return media URLs to joiners). We decode it, then delegate
/// to the repository to obtain a fresh attendee token for this device.
class JoinMeeting {
  const JoinMeeting(this._repository);

  final MeetingRepository _repository;

  Future<Either<Failure, MeetingSession>> call(String inviteCode) {
    final raw = InviteCodec.decode(inviteCode);
    if (raw == null) {
      return Future.value(
        const Left(
          MissingMeetingIdFailure('Enter a valid invite code from the host.'),
        ),
      );
    }
    final meeting = Meeting(
      meetingId: raw['MeetingId'] as String,
      externalMeetingId: raw['ExternalMeetingId'] as String?,
      mediaRegion: raw['MediaRegion'] as String?,
      rawMeetingJson: raw,
    );
    return _repository.joinAsClient(meeting);
  }
}
