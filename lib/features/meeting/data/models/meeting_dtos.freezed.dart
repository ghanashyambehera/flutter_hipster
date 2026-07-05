// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeetingResponseDto {

 String? get status; String? get message; MeetingDataDto? get data;
/// Create a copy of MeetingResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingResponseDtoCopyWith<MeetingResponseDto> get copyWith => _$MeetingResponseDtoCopyWithImpl<MeetingResponseDto>(this as MeetingResponseDto, _$identity);

  /// Serializes this MeetingResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingResponseDto&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,data);

@override
String toString() {
  return 'MeetingResponseDto(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $MeetingResponseDtoCopyWith<$Res>  {
  factory $MeetingResponseDtoCopyWith(MeetingResponseDto value, $Res Function(MeetingResponseDto) _then) = _$MeetingResponseDtoCopyWithImpl;
@useResult
$Res call({
 String? status, String? message, MeetingDataDto? data
});


$MeetingDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class _$MeetingResponseDtoCopyWithImpl<$Res>
    implements $MeetingResponseDtoCopyWith<$Res> {
  _$MeetingResponseDtoCopyWithImpl(this._self, this._then);

  final MeetingResponseDto _self;
  final $Res Function(MeetingResponseDto) _then;

/// Create a copy of MeetingResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MeetingDataDto?,
  ));
}
/// Create a copy of MeetingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeetingDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MeetingDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeetingResponseDto].
extension MeetingResponseDtoPatterns on MeetingResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _MeetingResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? status,  String? message,  MeetingDataDto? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingResponseDto() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? status,  String? message,  MeetingDataDto? data)  $default,) {final _that = this;
switch (_that) {
case _MeetingResponseDto():
return $default(_that.status,_that.message,_that.data);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? status,  String? message,  MeetingDataDto? data)?  $default,) {final _that = this;
switch (_that) {
case _MeetingResponseDto() when $default != null:
return $default(_that.status,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingResponseDto implements MeetingResponseDto {
  const _MeetingResponseDto({this.status, this.message, this.data});
  factory _MeetingResponseDto.fromJson(Map<String, dynamic> json) => _$MeetingResponseDtoFromJson(json);

@override final  String? status;
@override final  String? message;
@override final  MeetingDataDto? data;

/// Create a copy of MeetingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingResponseDtoCopyWith<_MeetingResponseDto> get copyWith => __$MeetingResponseDtoCopyWithImpl<_MeetingResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingResponseDto&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message,data);

@override
String toString() {
  return 'MeetingResponseDto(status: $status, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$MeetingResponseDtoCopyWith<$Res> implements $MeetingResponseDtoCopyWith<$Res> {
  factory _$MeetingResponseDtoCopyWith(_MeetingResponseDto value, $Res Function(_MeetingResponseDto) _then) = __$MeetingResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 String? status, String? message, MeetingDataDto? data
});


@override $MeetingDataDtoCopyWith<$Res>? get data;

}
/// @nodoc
class __$MeetingResponseDtoCopyWithImpl<$Res>
    implements _$MeetingResponseDtoCopyWith<$Res> {
  __$MeetingResponseDtoCopyWithImpl(this._self, this._then);

  final _MeetingResponseDto _self;
  final $Res Function(_MeetingResponseDto) _then;

/// Create a copy of MeetingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? message = freezed,Object? data = freezed,}) {
  return _then(_MeetingResponseDto(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as MeetingDataDto?,
  ));
}

/// Create a copy of MeetingResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeetingDataDtoCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $MeetingDataDtoCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$MeetingDataDto {

 ChimeMeetingDto get meeting; ChimeAttendeeDto get attendee;
/// Create a copy of MeetingDataDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeetingDataDtoCopyWith<MeetingDataDto> get copyWith => _$MeetingDataDtoCopyWithImpl<MeetingDataDto>(this as MeetingDataDto, _$identity);

  /// Serializes this MeetingDataDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeetingDataDto&&(identical(other.meeting, meeting) || other.meeting == meeting)&&(identical(other.attendee, attendee) || other.attendee == attendee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meeting,attendee);

@override
String toString() {
  return 'MeetingDataDto(meeting: $meeting, attendee: $attendee)';
}


}

/// @nodoc
abstract mixin class $MeetingDataDtoCopyWith<$Res>  {
  factory $MeetingDataDtoCopyWith(MeetingDataDto value, $Res Function(MeetingDataDto) _then) = _$MeetingDataDtoCopyWithImpl;
@useResult
$Res call({
 ChimeMeetingDto meeting, ChimeAttendeeDto attendee
});


$ChimeMeetingDtoCopyWith<$Res> get meeting;$ChimeAttendeeDtoCopyWith<$Res> get attendee;

}
/// @nodoc
class _$MeetingDataDtoCopyWithImpl<$Res>
    implements $MeetingDataDtoCopyWith<$Res> {
  _$MeetingDataDtoCopyWithImpl(this._self, this._then);

  final MeetingDataDto _self;
  final $Res Function(MeetingDataDto) _then;

/// Create a copy of MeetingDataDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meeting = null,Object? attendee = null,}) {
  return _then(_self.copyWith(
meeting: null == meeting ? _self.meeting : meeting // ignore: cast_nullable_to_non_nullable
as ChimeMeetingDto,attendee: null == attendee ? _self.attendee : attendee // ignore: cast_nullable_to_non_nullable
as ChimeAttendeeDto,
  ));
}
/// Create a copy of MeetingDataDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChimeMeetingDtoCopyWith<$Res> get meeting {
  
  return $ChimeMeetingDtoCopyWith<$Res>(_self.meeting, (value) {
    return _then(_self.copyWith(meeting: value));
  });
}/// Create a copy of MeetingDataDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChimeAttendeeDtoCopyWith<$Res> get attendee {
  
  return $ChimeAttendeeDtoCopyWith<$Res>(_self.attendee, (value) {
    return _then(_self.copyWith(attendee: value));
  });
}
}


/// Adds pattern-matching-related methods to [MeetingDataDto].
extension MeetingDataDtoPatterns on MeetingDataDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeetingDataDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeetingDataDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeetingDataDto value)  $default,){
final _that = this;
switch (_that) {
case _MeetingDataDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeetingDataDto value)?  $default,){
final _that = this;
switch (_that) {
case _MeetingDataDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChimeMeetingDto meeting,  ChimeAttendeeDto attendee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeetingDataDto() when $default != null:
return $default(_that.meeting,_that.attendee);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChimeMeetingDto meeting,  ChimeAttendeeDto attendee)  $default,) {final _that = this;
switch (_that) {
case _MeetingDataDto():
return $default(_that.meeting,_that.attendee);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChimeMeetingDto meeting,  ChimeAttendeeDto attendee)?  $default,) {final _that = this;
switch (_that) {
case _MeetingDataDto() when $default != null:
return $default(_that.meeting,_that.attendee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeetingDataDto implements MeetingDataDto {
  const _MeetingDataDto({required this.meeting, required this.attendee});
  factory _MeetingDataDto.fromJson(Map<String, dynamic> json) => _$MeetingDataDtoFromJson(json);

@override final  ChimeMeetingDto meeting;
@override final  ChimeAttendeeDto attendee;

/// Create a copy of MeetingDataDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeetingDataDtoCopyWith<_MeetingDataDto> get copyWith => __$MeetingDataDtoCopyWithImpl<_MeetingDataDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeetingDataDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeetingDataDto&&(identical(other.meeting, meeting) || other.meeting == meeting)&&(identical(other.attendee, attendee) || other.attendee == attendee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meeting,attendee);

@override
String toString() {
  return 'MeetingDataDto(meeting: $meeting, attendee: $attendee)';
}


}

/// @nodoc
abstract mixin class _$MeetingDataDtoCopyWith<$Res> implements $MeetingDataDtoCopyWith<$Res> {
  factory _$MeetingDataDtoCopyWith(_MeetingDataDto value, $Res Function(_MeetingDataDto) _then) = __$MeetingDataDtoCopyWithImpl;
@override @useResult
$Res call({
 ChimeMeetingDto meeting, ChimeAttendeeDto attendee
});


@override $ChimeMeetingDtoCopyWith<$Res> get meeting;@override $ChimeAttendeeDtoCopyWith<$Res> get attendee;

}
/// @nodoc
class __$MeetingDataDtoCopyWithImpl<$Res>
    implements _$MeetingDataDtoCopyWith<$Res> {
  __$MeetingDataDtoCopyWithImpl(this._self, this._then);

  final _MeetingDataDto _self;
  final $Res Function(_MeetingDataDto) _then;

/// Create a copy of MeetingDataDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meeting = null,Object? attendee = null,}) {
  return _then(_MeetingDataDto(
meeting: null == meeting ? _self.meeting : meeting // ignore: cast_nullable_to_non_nullable
as ChimeMeetingDto,attendee: null == attendee ? _self.attendee : attendee // ignore: cast_nullable_to_non_nullable
as ChimeAttendeeDto,
  ));
}

/// Create a copy of MeetingDataDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChimeMeetingDtoCopyWith<$Res> get meeting {
  
  return $ChimeMeetingDtoCopyWith<$Res>(_self.meeting, (value) {
    return _then(_self.copyWith(meeting: value));
  });
}/// Create a copy of MeetingDataDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChimeAttendeeDtoCopyWith<$Res> get attendee {
  
  return $ChimeAttendeeDtoCopyWith<$Res>(_self.attendee, (value) {
    return _then(_self.copyWith(attendee: value));
  });
}
}


/// @nodoc
mixin _$ChimeMeetingDto {

@JsonKey(name: 'MeetingId') String get meetingId;@JsonKey(name: 'ExternalMeetingId') String? get externalMeetingId;@JsonKey(name: 'MediaRegion') String? get mediaRegion;@JsonKey(name: 'MediaPlacement') MediaPlacementDto? get mediaPlacement;
/// Create a copy of ChimeMeetingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChimeMeetingDtoCopyWith<ChimeMeetingDto> get copyWith => _$ChimeMeetingDtoCopyWithImpl<ChimeMeetingDto>(this as ChimeMeetingDto, _$identity);

  /// Serializes this ChimeMeetingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChimeMeetingDto&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.externalMeetingId, externalMeetingId) || other.externalMeetingId == externalMeetingId)&&(identical(other.mediaRegion, mediaRegion) || other.mediaRegion == mediaRegion)&&(identical(other.mediaPlacement, mediaPlacement) || other.mediaPlacement == mediaPlacement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,externalMeetingId,mediaRegion,mediaPlacement);

@override
String toString() {
  return 'ChimeMeetingDto(meetingId: $meetingId, externalMeetingId: $externalMeetingId, mediaRegion: $mediaRegion, mediaPlacement: $mediaPlacement)';
}


}

/// @nodoc
abstract mixin class $ChimeMeetingDtoCopyWith<$Res>  {
  factory $ChimeMeetingDtoCopyWith(ChimeMeetingDto value, $Res Function(ChimeMeetingDto) _then) = _$ChimeMeetingDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'MeetingId') String meetingId,@JsonKey(name: 'ExternalMeetingId') String? externalMeetingId,@JsonKey(name: 'MediaRegion') String? mediaRegion,@JsonKey(name: 'MediaPlacement') MediaPlacementDto? mediaPlacement
});


$MediaPlacementDtoCopyWith<$Res>? get mediaPlacement;

}
/// @nodoc
class _$ChimeMeetingDtoCopyWithImpl<$Res>
    implements $ChimeMeetingDtoCopyWith<$Res> {
  _$ChimeMeetingDtoCopyWithImpl(this._self, this._then);

  final ChimeMeetingDto _self;
  final $Res Function(ChimeMeetingDto) _then;

/// Create a copy of ChimeMeetingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? meetingId = null,Object? externalMeetingId = freezed,Object? mediaRegion = freezed,Object? mediaPlacement = freezed,}) {
  return _then(_self.copyWith(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as String,externalMeetingId: freezed == externalMeetingId ? _self.externalMeetingId : externalMeetingId // ignore: cast_nullable_to_non_nullable
as String?,mediaRegion: freezed == mediaRegion ? _self.mediaRegion : mediaRegion // ignore: cast_nullable_to_non_nullable
as String?,mediaPlacement: freezed == mediaPlacement ? _self.mediaPlacement : mediaPlacement // ignore: cast_nullable_to_non_nullable
as MediaPlacementDto?,
  ));
}
/// Create a copy of ChimeMeetingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaPlacementDtoCopyWith<$Res>? get mediaPlacement {
    if (_self.mediaPlacement == null) {
    return null;
  }

  return $MediaPlacementDtoCopyWith<$Res>(_self.mediaPlacement!, (value) {
    return _then(_self.copyWith(mediaPlacement: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChimeMeetingDto].
extension ChimeMeetingDtoPatterns on ChimeMeetingDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChimeMeetingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChimeMeetingDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChimeMeetingDto value)  $default,){
final _that = this;
switch (_that) {
case _ChimeMeetingDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChimeMeetingDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChimeMeetingDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'MeetingId')  String meetingId, @JsonKey(name: 'ExternalMeetingId')  String? externalMeetingId, @JsonKey(name: 'MediaRegion')  String? mediaRegion, @JsonKey(name: 'MediaPlacement')  MediaPlacementDto? mediaPlacement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChimeMeetingDto() when $default != null:
return $default(_that.meetingId,_that.externalMeetingId,_that.mediaRegion,_that.mediaPlacement);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'MeetingId')  String meetingId, @JsonKey(name: 'ExternalMeetingId')  String? externalMeetingId, @JsonKey(name: 'MediaRegion')  String? mediaRegion, @JsonKey(name: 'MediaPlacement')  MediaPlacementDto? mediaPlacement)  $default,) {final _that = this;
switch (_that) {
case _ChimeMeetingDto():
return $default(_that.meetingId,_that.externalMeetingId,_that.mediaRegion,_that.mediaPlacement);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'MeetingId')  String meetingId, @JsonKey(name: 'ExternalMeetingId')  String? externalMeetingId, @JsonKey(name: 'MediaRegion')  String? mediaRegion, @JsonKey(name: 'MediaPlacement')  MediaPlacementDto? mediaPlacement)?  $default,) {final _that = this;
switch (_that) {
case _ChimeMeetingDto() when $default != null:
return $default(_that.meetingId,_that.externalMeetingId,_that.mediaRegion,_that.mediaPlacement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChimeMeetingDto implements ChimeMeetingDto {
  const _ChimeMeetingDto({@JsonKey(name: 'MeetingId') required this.meetingId, @JsonKey(name: 'ExternalMeetingId') this.externalMeetingId, @JsonKey(name: 'MediaRegion') this.mediaRegion, @JsonKey(name: 'MediaPlacement') this.mediaPlacement});
  factory _ChimeMeetingDto.fromJson(Map<String, dynamic> json) => _$ChimeMeetingDtoFromJson(json);

@override@JsonKey(name: 'MeetingId') final  String meetingId;
@override@JsonKey(name: 'ExternalMeetingId') final  String? externalMeetingId;
@override@JsonKey(name: 'MediaRegion') final  String? mediaRegion;
@override@JsonKey(name: 'MediaPlacement') final  MediaPlacementDto? mediaPlacement;

/// Create a copy of ChimeMeetingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChimeMeetingDtoCopyWith<_ChimeMeetingDto> get copyWith => __$ChimeMeetingDtoCopyWithImpl<_ChimeMeetingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChimeMeetingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChimeMeetingDto&&(identical(other.meetingId, meetingId) || other.meetingId == meetingId)&&(identical(other.externalMeetingId, externalMeetingId) || other.externalMeetingId == externalMeetingId)&&(identical(other.mediaRegion, mediaRegion) || other.mediaRegion == mediaRegion)&&(identical(other.mediaPlacement, mediaPlacement) || other.mediaPlacement == mediaPlacement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,meetingId,externalMeetingId,mediaRegion,mediaPlacement);

@override
String toString() {
  return 'ChimeMeetingDto(meetingId: $meetingId, externalMeetingId: $externalMeetingId, mediaRegion: $mediaRegion, mediaPlacement: $mediaPlacement)';
}


}

/// @nodoc
abstract mixin class _$ChimeMeetingDtoCopyWith<$Res> implements $ChimeMeetingDtoCopyWith<$Res> {
  factory _$ChimeMeetingDtoCopyWith(_ChimeMeetingDto value, $Res Function(_ChimeMeetingDto) _then) = __$ChimeMeetingDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'MeetingId') String meetingId,@JsonKey(name: 'ExternalMeetingId') String? externalMeetingId,@JsonKey(name: 'MediaRegion') String? mediaRegion,@JsonKey(name: 'MediaPlacement') MediaPlacementDto? mediaPlacement
});


@override $MediaPlacementDtoCopyWith<$Res>? get mediaPlacement;

}
/// @nodoc
class __$ChimeMeetingDtoCopyWithImpl<$Res>
    implements _$ChimeMeetingDtoCopyWith<$Res> {
  __$ChimeMeetingDtoCopyWithImpl(this._self, this._then);

  final _ChimeMeetingDto _self;
  final $Res Function(_ChimeMeetingDto) _then;

/// Create a copy of ChimeMeetingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? meetingId = null,Object? externalMeetingId = freezed,Object? mediaRegion = freezed,Object? mediaPlacement = freezed,}) {
  return _then(_ChimeMeetingDto(
meetingId: null == meetingId ? _self.meetingId : meetingId // ignore: cast_nullable_to_non_nullable
as String,externalMeetingId: freezed == externalMeetingId ? _self.externalMeetingId : externalMeetingId // ignore: cast_nullable_to_non_nullable
as String?,mediaRegion: freezed == mediaRegion ? _self.mediaRegion : mediaRegion // ignore: cast_nullable_to_non_nullable
as String?,mediaPlacement: freezed == mediaPlacement ? _self.mediaPlacement : mediaPlacement // ignore: cast_nullable_to_non_nullable
as MediaPlacementDto?,
  ));
}

/// Create a copy of ChimeMeetingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaPlacementDtoCopyWith<$Res>? get mediaPlacement {
    if (_self.mediaPlacement == null) {
    return null;
  }

  return $MediaPlacementDtoCopyWith<$Res>(_self.mediaPlacement!, (value) {
    return _then(_self.copyWith(mediaPlacement: value));
  });
}
}


/// @nodoc
mixin _$MediaPlacementDto {

@JsonKey(name: 'AudioHostUrl') String? get audioHostUrl;@JsonKey(name: 'AudioFallbackUrl') String? get audioFallbackUrl;@JsonKey(name: 'SignalingUrl') String? get signalingUrl;@JsonKey(name: 'TurnControlUrl') String? get turnControlUrl;@JsonKey(name: 'ScreenDataUrl') String? get screenDataUrl;@JsonKey(name: 'ScreenViewingUrl') String? get screenViewingUrl;@JsonKey(name: 'ScreenSharingUrl') String? get screenSharingUrl;@JsonKey(name: 'EventIngestionUrl') String? get eventIngestionUrl;
/// Create a copy of MediaPlacementDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaPlacementDtoCopyWith<MediaPlacementDto> get copyWith => _$MediaPlacementDtoCopyWithImpl<MediaPlacementDto>(this as MediaPlacementDto, _$identity);

  /// Serializes this MediaPlacementDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaPlacementDto&&(identical(other.audioHostUrl, audioHostUrl) || other.audioHostUrl == audioHostUrl)&&(identical(other.audioFallbackUrl, audioFallbackUrl) || other.audioFallbackUrl == audioFallbackUrl)&&(identical(other.signalingUrl, signalingUrl) || other.signalingUrl == signalingUrl)&&(identical(other.turnControlUrl, turnControlUrl) || other.turnControlUrl == turnControlUrl)&&(identical(other.screenDataUrl, screenDataUrl) || other.screenDataUrl == screenDataUrl)&&(identical(other.screenViewingUrl, screenViewingUrl) || other.screenViewingUrl == screenViewingUrl)&&(identical(other.screenSharingUrl, screenSharingUrl) || other.screenSharingUrl == screenSharingUrl)&&(identical(other.eventIngestionUrl, eventIngestionUrl) || other.eventIngestionUrl == eventIngestionUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,audioHostUrl,audioFallbackUrl,signalingUrl,turnControlUrl,screenDataUrl,screenViewingUrl,screenSharingUrl,eventIngestionUrl);

@override
String toString() {
  return 'MediaPlacementDto(audioHostUrl: $audioHostUrl, audioFallbackUrl: $audioFallbackUrl, signalingUrl: $signalingUrl, turnControlUrl: $turnControlUrl, screenDataUrl: $screenDataUrl, screenViewingUrl: $screenViewingUrl, screenSharingUrl: $screenSharingUrl, eventIngestionUrl: $eventIngestionUrl)';
}


}

/// @nodoc
abstract mixin class $MediaPlacementDtoCopyWith<$Res>  {
  factory $MediaPlacementDtoCopyWith(MediaPlacementDto value, $Res Function(MediaPlacementDto) _then) = _$MediaPlacementDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'AudioHostUrl') String? audioHostUrl,@JsonKey(name: 'AudioFallbackUrl') String? audioFallbackUrl,@JsonKey(name: 'SignalingUrl') String? signalingUrl,@JsonKey(name: 'TurnControlUrl') String? turnControlUrl,@JsonKey(name: 'ScreenDataUrl') String? screenDataUrl,@JsonKey(name: 'ScreenViewingUrl') String? screenViewingUrl,@JsonKey(name: 'ScreenSharingUrl') String? screenSharingUrl,@JsonKey(name: 'EventIngestionUrl') String? eventIngestionUrl
});




}
/// @nodoc
class _$MediaPlacementDtoCopyWithImpl<$Res>
    implements $MediaPlacementDtoCopyWith<$Res> {
  _$MediaPlacementDtoCopyWithImpl(this._self, this._then);

  final MediaPlacementDto _self;
  final $Res Function(MediaPlacementDto) _then;

/// Create a copy of MediaPlacementDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? audioHostUrl = freezed,Object? audioFallbackUrl = freezed,Object? signalingUrl = freezed,Object? turnControlUrl = freezed,Object? screenDataUrl = freezed,Object? screenViewingUrl = freezed,Object? screenSharingUrl = freezed,Object? eventIngestionUrl = freezed,}) {
  return _then(_self.copyWith(
audioHostUrl: freezed == audioHostUrl ? _self.audioHostUrl : audioHostUrl // ignore: cast_nullable_to_non_nullable
as String?,audioFallbackUrl: freezed == audioFallbackUrl ? _self.audioFallbackUrl : audioFallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,signalingUrl: freezed == signalingUrl ? _self.signalingUrl : signalingUrl // ignore: cast_nullable_to_non_nullable
as String?,turnControlUrl: freezed == turnControlUrl ? _self.turnControlUrl : turnControlUrl // ignore: cast_nullable_to_non_nullable
as String?,screenDataUrl: freezed == screenDataUrl ? _self.screenDataUrl : screenDataUrl // ignore: cast_nullable_to_non_nullable
as String?,screenViewingUrl: freezed == screenViewingUrl ? _self.screenViewingUrl : screenViewingUrl // ignore: cast_nullable_to_non_nullable
as String?,screenSharingUrl: freezed == screenSharingUrl ? _self.screenSharingUrl : screenSharingUrl // ignore: cast_nullable_to_non_nullable
as String?,eventIngestionUrl: freezed == eventIngestionUrl ? _self.eventIngestionUrl : eventIngestionUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaPlacementDto].
extension MediaPlacementDtoPatterns on MediaPlacementDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaPlacementDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaPlacementDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaPlacementDto value)  $default,){
final _that = this;
switch (_that) {
case _MediaPlacementDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaPlacementDto value)?  $default,){
final _that = this;
switch (_that) {
case _MediaPlacementDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'AudioHostUrl')  String? audioHostUrl, @JsonKey(name: 'AudioFallbackUrl')  String? audioFallbackUrl, @JsonKey(name: 'SignalingUrl')  String? signalingUrl, @JsonKey(name: 'TurnControlUrl')  String? turnControlUrl, @JsonKey(name: 'ScreenDataUrl')  String? screenDataUrl, @JsonKey(name: 'ScreenViewingUrl')  String? screenViewingUrl, @JsonKey(name: 'ScreenSharingUrl')  String? screenSharingUrl, @JsonKey(name: 'EventIngestionUrl')  String? eventIngestionUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaPlacementDto() when $default != null:
return $default(_that.audioHostUrl,_that.audioFallbackUrl,_that.signalingUrl,_that.turnControlUrl,_that.screenDataUrl,_that.screenViewingUrl,_that.screenSharingUrl,_that.eventIngestionUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'AudioHostUrl')  String? audioHostUrl, @JsonKey(name: 'AudioFallbackUrl')  String? audioFallbackUrl, @JsonKey(name: 'SignalingUrl')  String? signalingUrl, @JsonKey(name: 'TurnControlUrl')  String? turnControlUrl, @JsonKey(name: 'ScreenDataUrl')  String? screenDataUrl, @JsonKey(name: 'ScreenViewingUrl')  String? screenViewingUrl, @JsonKey(name: 'ScreenSharingUrl')  String? screenSharingUrl, @JsonKey(name: 'EventIngestionUrl')  String? eventIngestionUrl)  $default,) {final _that = this;
switch (_that) {
case _MediaPlacementDto():
return $default(_that.audioHostUrl,_that.audioFallbackUrl,_that.signalingUrl,_that.turnControlUrl,_that.screenDataUrl,_that.screenViewingUrl,_that.screenSharingUrl,_that.eventIngestionUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'AudioHostUrl')  String? audioHostUrl, @JsonKey(name: 'AudioFallbackUrl')  String? audioFallbackUrl, @JsonKey(name: 'SignalingUrl')  String? signalingUrl, @JsonKey(name: 'TurnControlUrl')  String? turnControlUrl, @JsonKey(name: 'ScreenDataUrl')  String? screenDataUrl, @JsonKey(name: 'ScreenViewingUrl')  String? screenViewingUrl, @JsonKey(name: 'ScreenSharingUrl')  String? screenSharingUrl, @JsonKey(name: 'EventIngestionUrl')  String? eventIngestionUrl)?  $default,) {final _that = this;
switch (_that) {
case _MediaPlacementDto() when $default != null:
return $default(_that.audioHostUrl,_that.audioFallbackUrl,_that.signalingUrl,_that.turnControlUrl,_that.screenDataUrl,_that.screenViewingUrl,_that.screenSharingUrl,_that.eventIngestionUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaPlacementDto implements MediaPlacementDto {
  const _MediaPlacementDto({@JsonKey(name: 'AudioHostUrl') this.audioHostUrl, @JsonKey(name: 'AudioFallbackUrl') this.audioFallbackUrl, @JsonKey(name: 'SignalingUrl') this.signalingUrl, @JsonKey(name: 'TurnControlUrl') this.turnControlUrl, @JsonKey(name: 'ScreenDataUrl') this.screenDataUrl, @JsonKey(name: 'ScreenViewingUrl') this.screenViewingUrl, @JsonKey(name: 'ScreenSharingUrl') this.screenSharingUrl, @JsonKey(name: 'EventIngestionUrl') this.eventIngestionUrl});
  factory _MediaPlacementDto.fromJson(Map<String, dynamic> json) => _$MediaPlacementDtoFromJson(json);

@override@JsonKey(name: 'AudioHostUrl') final  String? audioHostUrl;
@override@JsonKey(name: 'AudioFallbackUrl') final  String? audioFallbackUrl;
@override@JsonKey(name: 'SignalingUrl') final  String? signalingUrl;
@override@JsonKey(name: 'TurnControlUrl') final  String? turnControlUrl;
@override@JsonKey(name: 'ScreenDataUrl') final  String? screenDataUrl;
@override@JsonKey(name: 'ScreenViewingUrl') final  String? screenViewingUrl;
@override@JsonKey(name: 'ScreenSharingUrl') final  String? screenSharingUrl;
@override@JsonKey(name: 'EventIngestionUrl') final  String? eventIngestionUrl;

/// Create a copy of MediaPlacementDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaPlacementDtoCopyWith<_MediaPlacementDto> get copyWith => __$MediaPlacementDtoCopyWithImpl<_MediaPlacementDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaPlacementDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaPlacementDto&&(identical(other.audioHostUrl, audioHostUrl) || other.audioHostUrl == audioHostUrl)&&(identical(other.audioFallbackUrl, audioFallbackUrl) || other.audioFallbackUrl == audioFallbackUrl)&&(identical(other.signalingUrl, signalingUrl) || other.signalingUrl == signalingUrl)&&(identical(other.turnControlUrl, turnControlUrl) || other.turnControlUrl == turnControlUrl)&&(identical(other.screenDataUrl, screenDataUrl) || other.screenDataUrl == screenDataUrl)&&(identical(other.screenViewingUrl, screenViewingUrl) || other.screenViewingUrl == screenViewingUrl)&&(identical(other.screenSharingUrl, screenSharingUrl) || other.screenSharingUrl == screenSharingUrl)&&(identical(other.eventIngestionUrl, eventIngestionUrl) || other.eventIngestionUrl == eventIngestionUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,audioHostUrl,audioFallbackUrl,signalingUrl,turnControlUrl,screenDataUrl,screenViewingUrl,screenSharingUrl,eventIngestionUrl);

@override
String toString() {
  return 'MediaPlacementDto(audioHostUrl: $audioHostUrl, audioFallbackUrl: $audioFallbackUrl, signalingUrl: $signalingUrl, turnControlUrl: $turnControlUrl, screenDataUrl: $screenDataUrl, screenViewingUrl: $screenViewingUrl, screenSharingUrl: $screenSharingUrl, eventIngestionUrl: $eventIngestionUrl)';
}


}

/// @nodoc
abstract mixin class _$MediaPlacementDtoCopyWith<$Res> implements $MediaPlacementDtoCopyWith<$Res> {
  factory _$MediaPlacementDtoCopyWith(_MediaPlacementDto value, $Res Function(_MediaPlacementDto) _then) = __$MediaPlacementDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'AudioHostUrl') String? audioHostUrl,@JsonKey(name: 'AudioFallbackUrl') String? audioFallbackUrl,@JsonKey(name: 'SignalingUrl') String? signalingUrl,@JsonKey(name: 'TurnControlUrl') String? turnControlUrl,@JsonKey(name: 'ScreenDataUrl') String? screenDataUrl,@JsonKey(name: 'ScreenViewingUrl') String? screenViewingUrl,@JsonKey(name: 'ScreenSharingUrl') String? screenSharingUrl,@JsonKey(name: 'EventIngestionUrl') String? eventIngestionUrl
});




}
/// @nodoc
class __$MediaPlacementDtoCopyWithImpl<$Res>
    implements _$MediaPlacementDtoCopyWith<$Res> {
  __$MediaPlacementDtoCopyWithImpl(this._self, this._then);

  final _MediaPlacementDto _self;
  final $Res Function(_MediaPlacementDto) _then;

/// Create a copy of MediaPlacementDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? audioHostUrl = freezed,Object? audioFallbackUrl = freezed,Object? signalingUrl = freezed,Object? turnControlUrl = freezed,Object? screenDataUrl = freezed,Object? screenViewingUrl = freezed,Object? screenSharingUrl = freezed,Object? eventIngestionUrl = freezed,}) {
  return _then(_MediaPlacementDto(
audioHostUrl: freezed == audioHostUrl ? _self.audioHostUrl : audioHostUrl // ignore: cast_nullable_to_non_nullable
as String?,audioFallbackUrl: freezed == audioFallbackUrl ? _self.audioFallbackUrl : audioFallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,signalingUrl: freezed == signalingUrl ? _self.signalingUrl : signalingUrl // ignore: cast_nullable_to_non_nullable
as String?,turnControlUrl: freezed == turnControlUrl ? _self.turnControlUrl : turnControlUrl // ignore: cast_nullable_to_non_nullable
as String?,screenDataUrl: freezed == screenDataUrl ? _self.screenDataUrl : screenDataUrl // ignore: cast_nullable_to_non_nullable
as String?,screenViewingUrl: freezed == screenViewingUrl ? _self.screenViewingUrl : screenViewingUrl // ignore: cast_nullable_to_non_nullable
as String?,screenSharingUrl: freezed == screenSharingUrl ? _self.screenSharingUrl : screenSharingUrl // ignore: cast_nullable_to_non_nullable
as String?,eventIngestionUrl: freezed == eventIngestionUrl ? _self.eventIngestionUrl : eventIngestionUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChimeAttendeeDto {

@JsonKey(name: 'AttendeeId') String get attendeeId;@JsonKey(name: 'ExternalUserId') String get externalUserId;@JsonKey(name: 'JoinToken') String get joinToken;@JsonKey(name: 'Capabilities') Map<String, dynamic>? get capabilities;
/// Create a copy of ChimeAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChimeAttendeeDtoCopyWith<ChimeAttendeeDto> get copyWith => _$ChimeAttendeeDtoCopyWithImpl<ChimeAttendeeDto>(this as ChimeAttendeeDto, _$identity);

  /// Serializes this ChimeAttendeeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChimeAttendeeDto&&(identical(other.attendeeId, attendeeId) || other.attendeeId == attendeeId)&&(identical(other.externalUserId, externalUserId) || other.externalUserId == externalUserId)&&(identical(other.joinToken, joinToken) || other.joinToken == joinToken)&&const DeepCollectionEquality().equals(other.capabilities, capabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attendeeId,externalUserId,joinToken,const DeepCollectionEquality().hash(capabilities));

@override
String toString() {
  return 'ChimeAttendeeDto(attendeeId: $attendeeId, externalUserId: $externalUserId, joinToken: $joinToken, capabilities: $capabilities)';
}


}

/// @nodoc
abstract mixin class $ChimeAttendeeDtoCopyWith<$Res>  {
  factory $ChimeAttendeeDtoCopyWith(ChimeAttendeeDto value, $Res Function(ChimeAttendeeDto) _then) = _$ChimeAttendeeDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'AttendeeId') String attendeeId,@JsonKey(name: 'ExternalUserId') String externalUserId,@JsonKey(name: 'JoinToken') String joinToken,@JsonKey(name: 'Capabilities') Map<String, dynamic>? capabilities
});




}
/// @nodoc
class _$ChimeAttendeeDtoCopyWithImpl<$Res>
    implements $ChimeAttendeeDtoCopyWith<$Res> {
  _$ChimeAttendeeDtoCopyWithImpl(this._self, this._then);

  final ChimeAttendeeDto _self;
  final $Res Function(ChimeAttendeeDto) _then;

/// Create a copy of ChimeAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attendeeId = null,Object? externalUserId = null,Object? joinToken = null,Object? capabilities = freezed,}) {
  return _then(_self.copyWith(
attendeeId: null == attendeeId ? _self.attendeeId : attendeeId // ignore: cast_nullable_to_non_nullable
as String,externalUserId: null == externalUserId ? _self.externalUserId : externalUserId // ignore: cast_nullable_to_non_nullable
as String,joinToken: null == joinToken ? _self.joinToken : joinToken // ignore: cast_nullable_to_non_nullable
as String,capabilities: freezed == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChimeAttendeeDto].
extension ChimeAttendeeDtoPatterns on ChimeAttendeeDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChimeAttendeeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChimeAttendeeDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChimeAttendeeDto value)  $default,){
final _that = this;
switch (_that) {
case _ChimeAttendeeDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChimeAttendeeDto value)?  $default,){
final _that = this;
switch (_that) {
case _ChimeAttendeeDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'AttendeeId')  String attendeeId, @JsonKey(name: 'ExternalUserId')  String externalUserId, @JsonKey(name: 'JoinToken')  String joinToken, @JsonKey(name: 'Capabilities')  Map<String, dynamic>? capabilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChimeAttendeeDto() when $default != null:
return $default(_that.attendeeId,_that.externalUserId,_that.joinToken,_that.capabilities);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'AttendeeId')  String attendeeId, @JsonKey(name: 'ExternalUserId')  String externalUserId, @JsonKey(name: 'JoinToken')  String joinToken, @JsonKey(name: 'Capabilities')  Map<String, dynamic>? capabilities)  $default,) {final _that = this;
switch (_that) {
case _ChimeAttendeeDto():
return $default(_that.attendeeId,_that.externalUserId,_that.joinToken,_that.capabilities);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'AttendeeId')  String attendeeId, @JsonKey(name: 'ExternalUserId')  String externalUserId, @JsonKey(name: 'JoinToken')  String joinToken, @JsonKey(name: 'Capabilities')  Map<String, dynamic>? capabilities)?  $default,) {final _that = this;
switch (_that) {
case _ChimeAttendeeDto() when $default != null:
return $default(_that.attendeeId,_that.externalUserId,_that.joinToken,_that.capabilities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChimeAttendeeDto implements ChimeAttendeeDto {
  const _ChimeAttendeeDto({@JsonKey(name: 'AttendeeId') required this.attendeeId, @JsonKey(name: 'ExternalUserId') required this.externalUserId, @JsonKey(name: 'JoinToken') required this.joinToken, @JsonKey(name: 'Capabilities') final  Map<String, dynamic>? capabilities}): _capabilities = capabilities;
  factory _ChimeAttendeeDto.fromJson(Map<String, dynamic> json) => _$ChimeAttendeeDtoFromJson(json);

@override@JsonKey(name: 'AttendeeId') final  String attendeeId;
@override@JsonKey(name: 'ExternalUserId') final  String externalUserId;
@override@JsonKey(name: 'JoinToken') final  String joinToken;
 final  Map<String, dynamic>? _capabilities;
@override@JsonKey(name: 'Capabilities') Map<String, dynamic>? get capabilities {
  final value = _capabilities;
  if (value == null) return null;
  if (_capabilities is EqualUnmodifiableMapView) return _capabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ChimeAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChimeAttendeeDtoCopyWith<_ChimeAttendeeDto> get copyWith => __$ChimeAttendeeDtoCopyWithImpl<_ChimeAttendeeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChimeAttendeeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChimeAttendeeDto&&(identical(other.attendeeId, attendeeId) || other.attendeeId == attendeeId)&&(identical(other.externalUserId, externalUserId) || other.externalUserId == externalUserId)&&(identical(other.joinToken, joinToken) || other.joinToken == joinToken)&&const DeepCollectionEquality().equals(other._capabilities, _capabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attendeeId,externalUserId,joinToken,const DeepCollectionEquality().hash(_capabilities));

@override
String toString() {
  return 'ChimeAttendeeDto(attendeeId: $attendeeId, externalUserId: $externalUserId, joinToken: $joinToken, capabilities: $capabilities)';
}


}

/// @nodoc
abstract mixin class _$ChimeAttendeeDtoCopyWith<$Res> implements $ChimeAttendeeDtoCopyWith<$Res> {
  factory _$ChimeAttendeeDtoCopyWith(_ChimeAttendeeDto value, $Res Function(_ChimeAttendeeDto) _then) = __$ChimeAttendeeDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'AttendeeId') String attendeeId,@JsonKey(name: 'ExternalUserId') String externalUserId,@JsonKey(name: 'JoinToken') String joinToken,@JsonKey(name: 'Capabilities') Map<String, dynamic>? capabilities
});




}
/// @nodoc
class __$ChimeAttendeeDtoCopyWithImpl<$Res>
    implements _$ChimeAttendeeDtoCopyWith<$Res> {
  __$ChimeAttendeeDtoCopyWithImpl(this._self, this._then);

  final _ChimeAttendeeDto _self;
  final $Res Function(_ChimeAttendeeDto) _then;

/// Create a copy of ChimeAttendeeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attendeeId = null,Object? externalUserId = null,Object? joinToken = null,Object? capabilities = freezed,}) {
  return _then(_ChimeAttendeeDto(
attendeeId: null == attendeeId ? _self.attendeeId : attendeeId // ignore: cast_nullable_to_non_nullable
as String,externalUserId: null == externalUserId ? _self.externalUserId : externalUserId // ignore: cast_nullable_to_non_nullable
as String,joinToken: null == joinToken ? _self.joinToken : joinToken // ignore: cast_nullable_to_non_nullable
as String,capabilities: freezed == capabilities ? _self._capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
