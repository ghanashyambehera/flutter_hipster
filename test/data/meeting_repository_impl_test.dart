import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:meeting_app/core/error/failures.dart';
import 'package:meeting_app/features/meeting/data/datasources/meeting_api_client.dart';
import 'package:meeting_app/features/meeting/data/repositories/meeting_repository_impl.dart';
import 'package:meeting_app/features/meeting/domain/entities/meeting.dart';
import 'package:meeting_app/features/meeting/domain/entities/meeting_session.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  late _MockDio dio;
  late MeetingRepositoryImpl repository;

  final successData = {
    'status': 'success',
    'data': {
      'meeting': {
        'MeetingId': 'meeting-123',
        'MediaRegion': 'us-east-1',
        'MediaPlacement': {'AudioHostUrl': 'host:3478', 'SignalingUrl': 'wss://s'},
      },
      'attendee': {
        'AttendeeId': 'att-1',
        'ExternalUserId': 'user-a',
        'JoinToken': 'token-1',
      },
    },
  };

  Response<dynamic> okResponse(Map<String, dynamic> body) => Response<dynamic>(
        requestOptions: RequestOptions(path: '/meetings'),
        statusCode: 200,
        data: body,
      );

  setUp(() {
    dio = _MockDio();
    repository = MeetingRepositoryImpl(MeetingApiClient(dio: dio));
  });

  group('createMeeting', () {
    test('returns a MeetingSession (agent role) on success', () async {
      when(() => dio.post<dynamic>(any(),
              queryParameters: any(named: 'queryParameters'), data: any(named: 'data')))
          .thenAnswer((_) async => okResponse(successData));

      final result = await repository.createMeeting();

      expect(result.isRight(), isTrue);
      final session = result.getOrElse(() => throw StateError('expected Right'));
      expect(session.role, MeetingRole.agent);
      expect(session.meeting.meetingId, 'meeting-123');
      expect(session.attendee.joinToken, 'token-1');
    });

    test('maps status:error payload to MeetingCreationFailure', () async {
      when(() => dio.post<dynamic>(any(),
              queryParameters: any(named: 'queryParameters'), data: any(named: 'data')))
          .thenAnswer((_) async =>
              okResponse({'status': 'error', 'message': 'quota exceeded'}));

      final result = await repository.createMeeting();

      expect(result, const Left(MeetingCreationFailure('quota exceeded')));
    });

    test('maps a DioException timeout to NetworkFailure', () async {
      when(() => dio.post<dynamic>(any(),
              queryParameters: any(named: 'queryParameters'), data: any(named: 'data')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/meetings'),
        type: DioExceptionType.connectionTimeout,
      ));

      final result = await repository.createMeeting();

      expect(result.isLeft(), isTrue);
      result.fold((f) => expect(f, isA<NetworkFailure>()), (_) => fail('expected Left'));
    });

    test('maps a non-2xx response to ServerFailure with status code', () async {
      when(() => dio.post<dynamic>(any(),
              queryParameters: any(named: 'queryParameters'), data: any(named: 'data')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/meetings'),
        type: DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/meetings'),
          statusCode: 500,
          data: {'message': 'boom'},
        ),
      ));

      final result = await repository.createMeeting();

      result.fold((f) {
        expect(f, isA<ServerFailure>());
        expect((f as ServerFailure).statusCode, 500);
        expect(f.message, 'boom');
      }, (_) => fail('expected Left'));
    });
  });

  group('joinAsClient', () {
    // The full meeting (with MediaPlacement) is supplied by the caller (decoded
    // from the host's invite code); the join API only issues a fresh attendee.
    const hostMeeting = Meeting(
      meetingId: 'meeting-123',
      mediaRegion: 'us-east-1',
      rawMeetingJson: {
        'MeetingId': 'meeting-123',
        'MediaRegion': 'us-east-1',
        'MediaPlacement': {'AudioHostUrl': 'host:3478', 'SignalingUrl': 'wss://s'},
      },
    );

    // Join responses only echo the MeetingId — no MediaPlacement.
    final joinData = {
      'status': 'success',
      'data': {
        'meeting': {'MeetingId': 'meeting-123'},
        'attendee': {
          'AttendeeId': 'att-guest',
          'ExternalUserId': 'client',
          'JoinToken': 'guest-token',
        },
      },
    };

    test('keeps the host media placement and adopts the fresh attendee token',
        () async {
      when(() => dio.post<dynamic>(any(),
              queryParameters: any(named: 'queryParameters'), data: any(named: 'data')))
          .thenAnswer((_) async => okResponse(joinData));

      final result = await repository.joinAsClient(hostMeeting);

      final session = result.getOrElse(() => throw StateError('expected Right'));
      expect(session.role, MeetingRole.client);
      expect(session.meeting.meetingId, 'meeting-123');
      // MediaPlacement must survive from the host-supplied meeting.
      expect(
        session.meeting.rawMeetingJson['MediaPlacement'],
        isNotNull,
      );
      expect(session.attendee.joinToken, 'guest-token');
      expect(session.attendee.attendeeId, 'att-guest');
    });

    test('maps a status:error join payload to a failure', () async {
      when(() => dio.post<dynamic>(any(),
              queryParameters: any(named: 'queryParameters'), data: any(named: 'data')))
          .thenAnswer((_) async =>
              okResponse({'status': 'error', 'message': 'meeting not found'}));

      final result = await repository.joinAsClient(hostMeeting);

      expect(result.isLeft(), isTrue);
    });
  });
}
