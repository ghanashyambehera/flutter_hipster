import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meeting_app/core/config/app_config.dart';
import 'package:meeting_app/core/di/injection.dart';
import 'package:meeting_app/app.dart';

void main() {
  testWidgets('Home screen shows Create and Join entry points', (tester) async {
    if (sl.isRegistered<AppConfig>()) {
      await sl.reset();
    }
    configureDependencies(
      const AppConfig(
        apiBaseUrl: 'https://example.test/api',
        apiKey: 'test-key',
        useFakeRtc: true,
      ),
    );
    addTearDown(sl.reset);

    await tester.pumpWidget(const MeetingApp());

    expect(find.text('Create meeting (Host)'), findsOneWidget);
    expect(find.text('Join meeting (Guest)'), findsOneWidget);
    expect(find.byKey(const Key('meeting_id_field')), findsOneWidget);
  });
}
