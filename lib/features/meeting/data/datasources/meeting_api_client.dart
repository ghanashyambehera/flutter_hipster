import 'package:dio/dio.dart';

import '../models/meeting_dtos.dart';

/// How request parameters are sent to `POST /meetings`.
///
/// The API PDF shows a JSON body but the runnable Postman collection uses query
/// params. We default to [queryParams] and keep [jsonBody] as a one-switch
/// fallback if the server rejects query params at runtime.
enum RequestEncoding { queryParams, jsonBody }

/// Thin HTTP client over the single `POST /meetings` endpoint. Throws
/// [DioException] on transport/HTTP errors; the repository maps these to typed
/// failures (the client itself does no error interpretation beyond parsing).
class MeetingApiClient {
  MeetingApiClient({
    required Dio dio,
    this.encoding = RequestEncoding.queryParams,
  }) : _dio = dio;

  final Dio _dio;
  final RequestEncoding encoding;

  static const _path = '/meetings';

  Future<MeetingResponseDto> requestMeeting({
    required String type,
    String? meetingId,
  }) async {
    final Response<dynamic> response;
    switch (encoding) {
      case RequestEncoding.queryParams:
        response = await _dio.post<dynamic>(
          _path,
          queryParameters: {
            'type': type,
            'meeting_id': ?meetingId,
          },
        );
      case RequestEncoding.jsonBody:
        response = await _dio.post<dynamic>(
          _path,
          data: {
            'type': type,
            'meeting_id': ?meetingId,
          },
        );
    }

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return MeetingResponseDto.fromJson(data);
    }
    if (data is Map) {
      return MeetingResponseDto.fromJson(Map<String, dynamic>.from(data));
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'Unexpected response shape from $_path',
    );
  }
}
