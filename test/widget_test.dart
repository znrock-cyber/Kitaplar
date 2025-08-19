import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kitap_onerileri/main.dart';

void main() {
  testWidgets('App loads without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    
    // Wait for all animations and timers to complete
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verify that the app loads successfully
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}