import 'package:equatable/equatable.dart';

/// A participant's join credential. A fresh [joinToken] is issued on every
/// backend request. [rawAttendeeJson] preserves the exact payload for the
/// native bridge.
class Attendee extends Equatable {
  const Attendee({
    required this.attendeeId,
    required this.externalUserId,
    required this.joinToken,
    required this.rawAttendeeJson,
  });

  final String attendeeId;
  final String externalUserId;
  final String joinToken;
  final Map<String, dynamic> rawAttendeeJson;

  @override
  List<Object?> get props => [attendeeId, externalUserId, joinToken];
}
