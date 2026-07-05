import 'package:flutter_test/flutter_test.dart';

import 'package:meeting_app/core/utils/invite_codec.dart';

void main() {
  const rawMeeting = <String, dynamic>{
    'MeetingId': 'meeting-123',
    'MediaRegion': 'ap-southeast-1',
    'MediaPlacement': {
      'AudioHostUrl': 'host.chime.aws:3478',
      'AudioFallbackUrl': 'wss://fallback',
      'SignalingUrl': 'wss://signal',
      'TurnControlUrl': 'https://turn',
    },
  };

  test('encode → decode round-trips the full meeting object', () {
    final code = InviteCodec.encode(rawMeeting);
    final decoded = InviteCodec.decode(code);

    expect(decoded, isNotNull);
    expect(decoded!['MeetingId'], 'meeting-123');
    expect(
      (decoded['MediaPlacement'] as Map)['AudioHostUrl'],
      'host.chime.aws:3478',
    );
  });

  test('encode produces a URL-safe string (no + or /)', () {
    final code = InviteCodec.encode(rawMeeting);
    expect(code.contains('+'), isFalse);
    expect(code.contains('/'), isFalse);
  });

  test('decode tolerates surrounding whitespace', () {
    final code = InviteCodec.encode(rawMeeting);
    expect(InviteCodec.decode('  $code \n'), isNotNull);
  });

  test('decode returns null for garbage input', () {
    expect(InviteCodec.decode('not-a-code!!!'), isNull);
    expect(InviteCodec.decode(''), isNull);
  });

  test('decode returns null when MeetingId is missing', () {
    final code = InviteCodec.encode({'MediaRegion': 'x'});
    expect(InviteCodec.decode(code), isNull);
  });
}
