import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:good3_app_ypj/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('初回起動時は通知許可画面を表示する', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const KyouNoIikotoApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byIcon(Icons.notifications_active_outlined), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsNothing);
  });

  testWidgets('通知許可の確認後はホーム画面を表示する', (tester) async {
    SharedPreferences.setMockInitialValues({
      'notif_permission_asked_v1': true,
    });

    await tester.pumpWidget(const KyouNoIikotoApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.edit_note), findsWidgets);
    expect(find.byIcon(Icons.calendar_month_outlined), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });
}
