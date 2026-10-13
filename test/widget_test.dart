import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reclaim/lost_item.dart';
import 'package:reclaim/Pages/home_page.dart';

void main() {
  // make sure the home screen shows all three buttons
  testWidgets('Home screen has Login, Post, and Finder buttons',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Post'), findsOneWidget);
    expect(find.text('Finder'), findsOneWidget);
  });

  testWidgets('LostItem creates an item with correct properties', (WidgetTester tester) async {
    //Edit later once items have been added to UI
    LostItem testLostItem = LostItem('testPoster', 'testImagePath', ['testDescription'], false);
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    assert(testLostItem.getPoster() == 'testPoster');
    assert(testLostItem.getImagePath() == 'testImagePath');
    assert(testLostItem.getDescription() == ['testDescription']);
    assert(testLostItem.wasFound() == false);
  });

  // when nobody is logged in, the login button should be clickable (not greyed out)
  testWidgets('Login button is enabled when not logged in',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    final loginButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Login'),
    );
    expect(loginButton.onPressed, isNotNull);
  });

  // tapping post without logging in should show a message instead of opening the camera
  testWidgets('Post button asks you to log in first',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    await tester.tap(find.text('Post'));
    await tester.pump();

    expect(find.text('Please log in first'), findsOneWidget);
  });
}
