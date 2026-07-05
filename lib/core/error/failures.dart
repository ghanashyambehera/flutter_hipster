import 'package:equatable/equatable.dart';

/// Base type for all typed failures. No raw exception ever reaches the UI;
/// everything is mapped to a [Failure] with a user-presentable [message].
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Network connectivity / timeout problems.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error. Check your connection.']);
}

/// Non-2xx HTTP response from the backend.
class ServerFailure extends Failure {
  const ServerFailure(super.message, {this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Backend returned `status: "error"` while creating a meeting.
class MeetingCreationFailure extends Failure {
  const MeetingCreationFailure([super.message = 'Could not create the meeting.']);
}

/// A join was attempted without a meeting id.
class MissingMeetingIdFailure extends Failure {
  const MissingMeetingIdFailure([super.message = 'A Meeting ID is required to join.']);
}

/// Camera/microphone permission was denied by the user.
class PermissionFailure extends Failure {
  const PermissionFailure([
    super.message = 'Camera and microphone permissions are required to join a call.',
  ]);
}

/// A failure inside the real-time (Chime) layer.
class RtcFailure extends Failure {
  const RtcFailure([super.message = 'Real-time media error.']);
}

/// Anything not otherwise mapped — still typed, never a leaked exception.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong.']);
}
