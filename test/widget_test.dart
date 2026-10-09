// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reclaim/lost_item.dart';

import 'package:reclaim/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('LostItem creates an item with correct properties', (WidgetTester tester) async {
    //Edit later once items have been added to UI
    LostItem testLostItem = LostItem('testPoster', 'testImagePath', 'testDescription', false);
    await tester.pumpWidget(const MyApp());

    assert(testLostItem.getPoster() == 'testPoster');
    assert(testLostItem.getImagePath() == 'testImagePath');
    assert(testLostItem.getDescription() == 'testDescription');
    assert(testLostItem.wasFound() == false);
  });
}
