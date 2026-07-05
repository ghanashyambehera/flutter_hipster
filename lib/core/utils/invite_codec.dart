import 'dart:convert';

/// Encodes/decodes the full Chime meeting object into a single shareable
/// "invite code".
///
/// Why this exists: the backend only returns the `MediaPlacement` (audio,
/// signaling, TURN URLs) to the meeting *creator*. A join-by-id call
/// (`type=client&meeting_id=…`) returns only `{"MeetingId": …}` plus a fresh
/// attendee token — which is not enough for the Chime SDK to connect. Because
/// every attendee of a meeting shares the same `MediaPlacement`, the host must
/// hand the full meeting object to the guest. We serialize it as URL-safe
/// base64 so it can be copied/shared as one opaque string.
class InviteCodec {
  const InviteCodec._();

  /// Serializes the raw meeting JSON (as returned by the backend for the host)
  /// into a URL-safe base64 invite code.
  static String encode(Map<String, dynamic> rawMeetingJson) {
    return base64Url.encode(utf8.encode(jsonEncode(rawMeetingJson)));
  }

  /// Decodes an invite [code] back into the raw meeting map. Returns `null`
  /// when the code is empty, malformed, or missing a `MeetingId`.
  static Map<String, dynamic>? decode(String code) {
    final trimmed = code.trim();
    if (trimmed.isEmpty) return null;
    try {
      final jsonStr = utf8.decode(base64Url.decode(base64Url.normalize(trimmed)));
      final decoded = jsonDecode(jsonStr);
      if (decoded is Map<String, dynamic> && decoded['MeetingId'] is String) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
