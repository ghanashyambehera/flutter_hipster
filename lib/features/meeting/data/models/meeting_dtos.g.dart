// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingResponseDto _$MeetingResponseDtoFromJson(Map<String, dynamic> json) =>
    _MeetingResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : MeetingDataDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeetingResponseDtoToJson(_MeetingResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data?.toJson(),
    };

_MeetingDataDto _$MeetingDataDtoFromJson(
  Map<String, dynamic> json,
) => _MeetingDataDto(
  meeting: ChimeMeetingDto.fromJson(json['meeting'] as Map<String, dynamic>),
  attendee: ChimeAttendeeDto.fromJson(json['attendee'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MeetingDataDtoToJson(_MeetingDataDto instance) =>
    <String, dynamic>{
      'meeting': instance.meeting.toJson(),
      'attendee': instance.attendee.toJson(),
    };

_ChimeMeetingDto _$ChimeMeetingDtoFromJson(Map<String, dynamic> json) =>
    _ChimeMeetingDto(
      meetingId: json['MeetingId'] as String,
      externalMeetingId: json['ExternalMeetingId'] as String?,
      mediaRegion: json['MediaRegion'] as String?,
      mediaPlacement: json['MediaPlacement'] == null
          ? null
          : MediaPlacementDto.fromJson(
              json['MediaPlacement'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ChimeMeetingDtoToJson(_ChimeMeetingDto instance) =>
    <String, dynamic>{
      'MeetingId': instance.meetingId,
      'ExternalMeetingId': instance.externalMeetingId,
      'MediaRegion': instance.mediaRegion,
      'MediaPlacement': instance.mediaPlacement?.toJson(),
    };

_MediaPlacementDto _$MediaPlacementDtoFromJson(Map<String, dynamic> json) =>
    _MediaPlacementDto(
      audioHostUrl: json['AudioHostUrl'] as String?,
      audioFallbackUrl: json['AudioFallbackUrl'] as String?,
      signalingUrl: json['SignalingUrl'] as String?,
      turnControlUrl: json['TurnControlUrl'] as String?,
      screenDataUrl: json['ScreenDataUrl'] as String?,
      screenViewingUrl: json['ScreenViewingUrl'] as String?,
      screenSharingUrl: json['ScreenSharingUrl'] as String?,
      eventIngestionUrl: json['EventIngestionUrl'] as String?,
    );

Map<String, dynamic> _$MediaPlacementDtoToJson(_MediaPlacementDto instance) =>
    <String, dynamic>{
      'AudioHostUrl': instance.audioHostUrl,
      'AudioFallbackUrl': instance.audioFallbackUrl,
      'SignalingUrl': instance.signalingUrl,
      'TurnControlUrl': instance.turnControlUrl,
      'ScreenDataUrl': instance.screenDataUrl,
      'ScreenViewingUrl': instance.screenViewingUrl,
      'ScreenSharingUrl': instance.screenSharingUrl,
      'EventIngestionUrl': instance.eventIngestionUrl,
    };

_ChimeAttendeeDto _$ChimeAttendeeDtoFromJson(Map<String, dynamic> json) =>
    _ChimeAttendeeDto(
      attendeeId: json['AttendeeId'] as String,
      externalUserId: json['ExternalUserId'] as String,
      joinToken: json['JoinToken'] as String,
      capabilities: json['Capabilities'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ChimeAttendeeDtoToJson(_ChimeAttendeeDto instance) =>
    <String, dynamic>{
      'AttendeeId': instance.attendeeId,
      'ExternalUserId': instance.externalUserId,
      'JoinToken': instance.joinToken,
      'Capabilities': instance.capabilities,
    };
