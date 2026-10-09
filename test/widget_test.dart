import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
}