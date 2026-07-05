import 'package:flutter_test/flutter_test.dart';
import 'package:meeting_app/features/meeting/data/mappers/meeting_mapper.dart';
import 'package:meeting_app/features/meeting/data/models/meeting_dtos.dart';
import 'package:meeting_app/features/meeting/domain/entities/meeting_session.dart';

void main() {
  // Sample payload mirrors the real Chime CreateMeeting + CreateAttendee shape.
  final sampleData = <String, dynamic>{
    'meeting': {
      'MeetingId': '3b6b1b0e-1111-2222-3333-444455556666',
      'ExternalMeetingId': 'ext-meeting',
      'MediaRegion': 'us-east-1',
      'MediaPlacement': {
        'AudioHostUrl': 'k.m3.ue1.app.chime.aws:3478',
        'SignalingUrl': 'wss://signal.example',
        'TurnControlUrl': 'https://ccp.example',
      },
    },
    'attendee': {
      'AttendeeId': 'attendee-aaa',
      'ExternalUserId': 'user-a',
      'JoinToken': 'join-token-xyz',
      'Capabilities': {'Audio': 'SendReceive', 'Video': 'SendReceive'},
    },
  };

  group('DTO parsing & mapping', () {
    test('parses the response envelope and maps to a MeetingSession', () {
      final response = MeetingResponseDto.fromJson({
        'status': 'success',
        'data': sampleData,
      });

      expect(response.status, 'success');
      expect(response.data, isNotNull);

      final session = response.data!.toSession(MeetingRole.agent);
      expect(session.role, MeetingRole.agent);
      expect(session.meeting.meetingId, '3b6b1b0e-1111-2222-3333-444455556666');
      expect(session.meeting.mediaRegion, 'us-east-1');
      expect(session.attendee.attendeeId, 'attendee-aaa');
      expect(session.attendee.joinToken, 'join-token-xyz');
    });

    test('retains raw JSON with original Chime keys for the native bridge', () {
      final data = MeetingDataDto.fromJson(sampleData);
      final session = data.toSession(MeetingRole.client);

      // The raw maps must keep PascalCase keys so Kotlin can rebuild the SDK
      // response objects verbatim.
      expect(session.meeting.rawMeetingJson['MeetingId'], isNotNull);
      expect(session.meeting.rawMeetingJson['MediaPlacement'], isA<Map>());
      expect(session.attendee.rawAttendeeJson['JoinToken'], 'join-token-xyz');
    });

    test('parses an error envelope with a null data object', () {
      final response = MeetingResponseDto.fromJson({
        'status': 'error',
        'message': 'meeting_id is required',
      });

      expect(response.status, 'error');
      expect(response.data, isNull);
      expect(response.message, 'meeting_id is required');
    });
  });
}
