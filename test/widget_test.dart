// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jordan_guide/main.dart';

void main() {
  testWidgets('Login page displays correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const JordanGuideApp());

    // Verify that the login page is shown.
    expect(find.text('دليل الأردن السياحي'), findsOneWidget);
    expect(find.text('اكتشف عبق التاريخ بلمسة ذكية'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'البريد الإلكتروني'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'كلمة المرور'), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsOneWidget);
  });
}



