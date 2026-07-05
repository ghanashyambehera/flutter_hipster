import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/meeting_session.dart';
import '../ports/meeting_repository.dart';

/// Creates a new meeting as the Host.
class CreateMeeting {
  const CreateMeeting(this._repository);

  final MeetingRepository _repository;

  Future<Either<Failure, MeetingSession>> call() => _repository.createMeeting();
}
