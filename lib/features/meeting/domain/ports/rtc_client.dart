import '../entities/meeting_session.dart';
import 'rtc_event.dart';

/// Domain-level abstraction over the real-time media engine (Amazon Chime).
///
/// The concrete implementation (native Android bridge) lives in the data layer;
/// a fake implementation powers tests and an SDK-independent demo. UI/bloc code
/// depends only on this port — never on platform channels or Chime types
/// (constitution Article I).
abstract class RtcClient {
  /// Starts the audio/video session for [session] and begins local video.
  Future<void> start(MeetingSession session);

  /// Stops the session and releases resources.
  Future<void> stop();

  /// Mutes/unmutes the local microphone.
  Future<void> setMuted(bool muted);

  /// Enables/disables the local camera.
  Future<void> setCameraEnabled(bool enabled);

  /// Toggles between front and back cameras.
  Future<void> switchCamera();

  /// Stream of session events (connection lifecycle, attendees, video tiles).
  Stream<RtcEvent> get events;
}
