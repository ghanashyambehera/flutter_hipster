import 'package:equatable/equatable.dart';

import '../../domain/ports/rtc_event.dart';

/// UI-originated (and internal) events the [MeetingBloc] reacts to. Named
/// `MeetingUiEvent` to avoid clashing with the domain `MeetingEvent` (log) type.
sealed class MeetingUiEvent extends Equatable {
  const MeetingUiEvent();

  @override
  List<Object?> get props => [];
}

class CreateMeetingRequested extends MeetingUiEvent {
  const CreateMeetingRequested();
}

class JoinMeetingRequested extends MeetingUiEvent {
  const JoinMeetingRequested(this.meetingId);

  final String meetingId;

  @override
  List<Object?> get props => [meetingId];
}

class MicToggled extends MeetingUiEvent {
  const MicToggled();
}

class CameraToggled extends MeetingUiEvent {
  const CameraToggled();
}

class CameraSwitched extends MeetingUiEvent {
  const CameraSwitched();
}

class LeaveRequested extends MeetingUiEvent {
  const LeaveRequested();
}

/// Reset back to Idle (e.g. dismissing an error screen / starting over).
class MeetingReset extends MeetingUiEvent {
  const MeetingReset();
}

/// Open the OS app settings so the user can grant a denied permission.
class OpenAppSettingsRequested extends MeetingUiEvent {
  const OpenAppSettingsRequested();
}

/// Internal: an [RtcEvent] arrived from the RTC layer.
class RtcEventReceived extends MeetingUiEvent {
  const RtcEventReceived(this.event);

  final RtcEvent event;

  @override
  List<Object?> get props => [event];
}
