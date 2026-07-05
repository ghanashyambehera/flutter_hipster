import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/entities/meeting_session.dart';
import '../../domain/ports/meeting_repository.dart';
import '../datasources/meeting_api_client.dart';
import '../mappers/meeting_mapper.dart';
import '../models/meeting_dtos.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  const MeetingRepositoryImpl(this._client);

  final MeetingApiClient _client;

  @override
  Future<Either<Failure, MeetingSession>> createMeeting() =>
      _request(type: 'agent', role: MeetingRole.agent);

  @override
  Future<Either<Failure, MeetingSession>> joinAsClient(Meeting meeting) async {
    try {
      final dto = await _client.requestMeeting(
        type: 'client',
        meetingId: meeting.meetingId,
      );
      if (dto.status == 'error' || dto.data == null) {
        final message = dto.message ?? 'The server rejected the request.';
        if (message.toLowerCase().contains('meeting_id')) {
          return Left(MissingMeetingIdFailure(message));
        }
        return Left(MeetingCreationFailure(message));
      }
      // The join response only echoes the MeetingId (no MediaPlacement), so we
      // keep the full meeting shared by the host and adopt only the freshly
      // issued attendee token for this device.
      return Right(MeetingSession(
        meeting: meeting,
        attendee: dto.data!.attendee.toEntity(),
        role: MeetingRole.client,
      ));
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MeetingSession>> refreshAgent(String meetingId) {
    if (meetingId.trim().isEmpty) {
      return Future.value(const Left(MissingMeetingIdFailure()));
    }
    return _request(
      type: 'agent',
      meetingId: meetingId.trim(),
      role: MeetingRole.agent,
    );
  }

  Future<Either<Failure, MeetingSession>> _request({
    required String type,
    required MeetingRole role,
    String? meetingId,
  }) async {
    try {
      final dto = await _client.requestMeeting(type: type, meetingId: meetingId);
      return _toSession(dto, role);
    } on DioException catch (e) {
      return Left(_mapDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  Either<Failure, MeetingSession> _toSession(
    MeetingResponseDto dto,
    MeetingRole role,
  ) {
    // Backend signals logical errors via `status: "error"` even on HTTP 200.
    if (dto.status == 'error' || dto.data == null) {
      final message = dto.message ?? 'The server rejected the request.';
      if (message.toLowerCase().contains('meeting_id')) {
        return Left(MissingMeetingIdFailure(message));
      }
      return Left(MeetingCreationFailure(message));
    }
    return Right(dto.data!.toSession(role));
  }

  Failure _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        final serverMessage = _extractMessage(e.response?.data) ??
            'Server returned an error (${code ?? 'unknown'}).';
        return ServerFailure(serverMessage, statusCode: code);
      case DioExceptionType.cancel:
        return const NetworkFailure('The request was cancelled.');
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return NetworkFailure(e.message ?? 'Network error.');
    }
  }

  String? _extractMessage(dynamic data) {
    if (data is Map && data['message'] is String) {
      return data['message'] as String;
    }
    return null;
  }
}
