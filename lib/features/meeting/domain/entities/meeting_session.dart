import 'package:equatable/equatable.dart';

import 'attendee.dart';
import 'meeting.dart';

/// The role a local user plays. `agent` = Host (creator), `client` = Guest.
enum MeetingRole { agent, client }

/// The result of a create/join request: a meeting plus the local attendee
/// credential and the role under which it was obtained.
class MeetingSession extends Equatable {
  const MeetingSession({
    required this.meeting,
    required this.attendee,
    required this.role,
  });

  final Meeting meeting;
  final Attendee attendee;
  final MeetingRole role;

  @override
  List<Object?> get props => [meeting, attendee, role];
}
