import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/presentation/pages/about_page.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  testWidgets('Description app text should display',
      (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(AboutPage()));

    expect(find.text(ABOUT_DESCRIPTION_TEXT), findsOneWidget);
  });
}
