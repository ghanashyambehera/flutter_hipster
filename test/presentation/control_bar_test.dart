import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meeting_app/features/meeting/presentation/widgets/control_bar.dart';
import 'package:meeting_app/features/meeting/presentation/widgets/status_chip.dart';
import 'package:meeting_app/features/meeting/domain/entities/connection_status.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('ControlBar', () {
    testWidgets('reflects mic/camera state and reports taps', (tester) async {
      var micTaps = 0;
      var cameraTaps = 0;
      var switchTaps = 0;
      var leaveTaps = 0;

      await tester.pumpWidget(_wrap(ControlBar(
        micOn: true,
        cameraOn: false,
        onToggleMic: () => micTaps++,
        onToggleCamera: () => cameraTaps++,
        onSwitchCamera: () => switchTaps++,
        onLeave: () => leaveTaps++,
      )));

      // micOn -> shows the "mute" affordance; cameraOff -> camera_off icon.
      expect(find.byIcon(Icons.mic), findsOneWidget);
      expect(find.byIcon(Icons.videocam_off), findsOneWidget);

      await tester.tap(find.byKey(const Key('control_mic')));
      await tester.tap(find.byKey(const Key('control_camera')));
      await tester.tap(find.byKey(const Key('control_switch')));
      await tester.tap(find.byKey(const Key('control_leave')));
      await tester.pump();

      expect(micTaps, 1);
      expect(cameraTaps, 1);
      expect(switchTaps, 1);
      expect(leaveTaps, 1);
    });
  });

  group('StatusChip', () {
    testWidgets('renders the label for each connection status', (tester) async {
      for (final (status, label) in const [
        (ConnectionStatus.idle, 'Idle'),
        (ConnectionStatus.joining, 'Joining…'),
        (ConnectionStatus.connected, 'Connected'),
        (ConnectionStatus.disconnected, 'Disconnected'),
        (ConnectionStatus.error, 'Error'),
      ]) {
        await tester.pumpWidget(_wrap(StatusChip(status: status)));
        expect(find.text(label), findsOneWidget);
      }
    });
  });
}
