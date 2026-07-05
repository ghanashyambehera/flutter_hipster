import 'dart:async';

import '../../domain/entities/meeting_session.dart';
import '../../domain/ports/rtc_client.dart';
import '../../domain/ports/rtc_event.dart';

/// In-memory [RtcClient] that simulates a Chime session lifecycle. Enables the
/// entire app (create → join → controls → leave → event log) to be demoed and
/// tested without the native SDK (constitution Article IX; plan critical path).
class FakeRtcClient implements RtcClient {
  final StreamController<RtcEvent> _controller =
      StreamController<RtcEvent>.broadcast();

  static const int _localTileId = 1;
  static const int _remoteTileId = 2;

  final List<Timer> _timers = [];
  bool _started = false;

  @override
  Stream<RtcEvent> get events => _controller.stream;

  @override
  Future<void> start(MeetingSession session) async {
    _started = true;
    // Simulate the SDK confirming the connection shortly after start.
    _schedule(const Duration(milliseconds: 400), () {
      _emit(const RtcConnected());
      _emit(const RtcVideoTileAdded(tileId: _localTileId, isLocal: true));
    });
    // Simulate a remote participant joining a moment later.
    _schedule(const Duration(milliseconds: 1600), () {
      _emit(const RtcAttendeeJoined('remote-attendee'));
      _emit(const RtcVideoTileAdded(
        tileId: _remoteTileId,
        isLocal: false,
        attendeeId: 'remote-attendee',
      ));
    });
  }

  @override
  Future<void> stop() async {
    if (!_started) return;
    _started = false;
    _cancelTimers();
    _emit(const RtcDisconnected('left'));
  }

  @override
  Future<void> setMuted(bool muted) async {}

  @override
  Future<void> setCameraEnabled(bool enabled) async {
    // Reflect camera toggles as tile add/remove so the UI updates like the SDK.
    if (enabled) {
      _emit(const RtcVideoTileAdded(tileId: _localTileId, isLocal: true));
    } else {
      _emit(const RtcVideoTileRemoved(_localTileId));
    }
  }

  @override
  Future<void> switchCamera() async {}

  void _schedule(Duration delay, void Function() action) {
    _timers.add(Timer(delay, () {
      if (_started) action();
    }));
  }

  void _emit(RtcEvent event) {
    if (!_controller.isClosed) _controller.add(event);
  }

  void _cancelTimers() {
    for (final t in _timers) {
      t.cancel();
    }
    _timers.clear();
  }

  void dispose() {
    _cancelTimers();
    _controller.close();
  }
}
