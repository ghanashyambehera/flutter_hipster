import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_dtos.freezed.dart';
part 'meeting_dtos.g.dart';

/// Top-level `POST /meetings` response envelope.
@freezed
abstract class MeetingResponseDto with _$MeetingResponseDto {
  const factory MeetingResponseDto({
    String? status,
    String? message,
    MeetingDataDto? data,
  }) = _MeetingResponseDto;

  factory MeetingResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MeetingResponseDtoFromJson(json);
}

/// The `data` object carrying the Chime meeting + attendee.
@freezed
abstract class MeetingDataDto with _$MeetingDataDto {
  const factory MeetingDataDto({
    required ChimeMeetingDto meeting,
    required ChimeAttendeeDto attendee,
  }) = _MeetingDataDto;

  factory MeetingDataDto.fromJson(Map<String, dynamic> json) =>
      _$MeetingDataDtoFromJson(json);
}

/// Chime `CreateMeeting` shape. JSON keys preserved verbatim so the native
/// bridge can reconstruct the SDK response object.
@freezed
abstract class ChimeMeetingDto with _$ChimeMeetingDto {
  const factory ChimeMeetingDto({
    @JsonKey(name: 'MeetingId') required String meetingId,
    @JsonKey(name: 'ExternalMeetingId') String? externalMeetingId,
    @JsonKey(name: 'MediaRegion') String? mediaRegion,
    @JsonKey(name: 'MediaPlacement') MediaPlacementDto? mediaPlacement,
  }) = _ChimeMeetingDto;

  factory ChimeMeetingDto.fromJson(Map<String, dynamic> json) =>
      _$ChimeMeetingDtoFromJson(json);
}

/// Chime `MediaPlacement` URLs.
@freezed
abstract class MediaPlacementDto with _$MediaPlacementDto {
  const factory MediaPlacementDto({
    @JsonKey(name: 'AudioHostUrl') String? audioHostUrl,
    @JsonKey(name: 'AudioFallbackUrl') String? audioFallbackUrl,
    @JsonKey(name: 'SignalingUrl') String? signalingUrl,
    @JsonKey(name: 'TurnControlUrl') String? turnControlUrl,
    @JsonKey(name: 'ScreenDataUrl') String? screenDataUrl,
    @JsonKey(name: 'ScreenViewingUrl') String? screenViewingUrl,
    @JsonKey(name: 'ScreenSharingUrl') String? screenSharingUrl,
    @JsonKey(name: 'EventIngestionUrl') String? eventIngestionUrl,
  }) = _MediaPlacementDto;

  factory MediaPlacementDto.fromJson(Map<String, dynamic> json) =>
      _$MediaPlacementDtoFromJson(json);
}

/// Chime `CreateAttendee` shape.
@freezed
abstract class ChimeAttendeeDto with _$ChimeAttendeeDto {
  const factory ChimeAttendeeDto({
    @JsonKey(name: 'AttendeeId') required String attendeeId,
    @JsonKey(name: 'ExternalUserId') required String externalUserId,
    @JsonKey(name: 'JoinToken') required String joinToken,
    @JsonKey(name: 'Capabilities') Map<String, dynamic>? capabilities,
  }) = _ChimeAttendeeDto;

  factory ChimeAttendeeDto.fromJson(Map<String, dynamic> json) =>
      _$ChimeAttendeeDtoFromJson(json);
}
