import 'dart:async';

import 'package:flutter/services.dart';

import '../../domain/entities/meeting_session.dart';
import '../../domain/ports/rtc_client.dart';
import '../../domain/ports/rtc_event.dart';

/// Real-time client backed by the native `amazon-chime-sdk-android` engine.
///
/// This is the ONLY place platform channels/Chime types are referenced (data
/// layer). Commands go out over a [MethodChannel]; SDK observer callbacks come
/// back over an [EventChannel] and are mapped to transport-agnostic [RtcEvent]s.
class ChimeAndroidBridge implements RtcClient {
  ChimeAndroidBridge({MethodChannel? commandChannel, EventChannel? eventChannel})  
  : _commands = commandChannel ?? const MethodChannel('chime/commands'),
        _eventChannel = eventChannel ?? const EventChannel('chime/events');

  final MethodChannel _commands;
  final EventChannel _eventChannel;

  Stream<RtcEvent>? _events;

  @override
  Stream<RtcEvent> get events {
    _events ??= _eventChannel
        .receiveBroadcastStream()
        .map(_mapEvent)
        .where((e) => e != null)
        .cast<RtcEvent>();
    return _events!;
  }

  @override
  Future<void> start(MeetingSession session) {
    return _commands.invokeMethod<void>('start', {
      'meeting': session.meeting.rawMeetingJson,
      'attendee': session.attendee.rawAttendeeJson,
    });
  }

  @override
  Future<void> stop() => _commands.invokeMethod<void>('stop');

  @override
  Future<void> setMuted(bool muted) =>
      _commands.invokeMethod<void>('setMuted', {'muted': muted});

  @override
  Future<void> setCameraEnabled(bool enabled) =>
      _commands.invokeMethod<void>('setCameraEnabled', {'enabled': enabled});

  @override
  Future<void> switchCamera() => _commands.invokeMethod<void>('switchCamera');

  /// Translates the native event map into an [RtcEvent]. Unknown types are
  /// dropped (returns null) rather than throwing.
  RtcEvent? _mapEvent(dynamic raw) {
    if (raw is! Map) return null;
    final map = Map<String, dynamic>.from(raw);
    switch (map['type'] as String?) {
      case 'connected':
        return const RtcConnected();
      case 'disconnected':
        return RtcDisconnected(map['reason'] as String?);
      case 'attendeeJoined':
        return RtcAttendeeJoined(map['attendeeId'] as String? ?? '');
      case 'attendeeLeft':
        return RtcAttendeeLeft(map['attendeeId'] as String? ?? '');
      case 'videoTileAdded':
        return RtcVideoTileAdded(
          tileId: (map['tileId'] as num?)?.toInt() ?? -1,
          isLocal: map['isLocal'] as bool? ?? false,
          attendeeId: map['attendeeId'] as String?,
        );
      case 'videoTileRemoved':
        return RtcVideoTileRemoved((map['tileId'] as num?)?.toInt() ?? -1);
      case 'error':
        return RtcError(map['message'] as String? ?? 'Unknown Chime error');
      default:
        return null;
    }
  }
}
