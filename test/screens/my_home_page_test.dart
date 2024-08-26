import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_task/screens/my_home_page.dart';
import 'package:flutter_test_task/utils/colors.dart';

void main() {
  testWidgets('MyHomePage has a title and a sign-up button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));

    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Enter your password'), findsOneWidget);

    final Finder signUpButton = find.text('Sign up');
    expect(signUpButton, findsOneWidget);
    expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, equals(0.5));
  });

  testWidgets('MyHomePage enables the sign-up button when form is valid', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));

    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'Password1');

    await tester.pump();

    final Finder signUpButton = find.text('Sign up');

    expect(tester.widget<Opacity>(find.ancestor(of: signUpButton, matching: find.byType(Opacity))).opacity, equals(1.0));
  });
  testWidgets('MyHomePage shows password criteria as default with focused input', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));

    await tester.enterText(find.byType(TextFormField).at(1), 'Pass');

    await tester.pump();

    final textWidget1 = tester.widget<Text>(find.text('8 characters or more (no spaces)'));
    expect(textWidget1.style?.color, equals(colorPrimary));

    final textWidget3 = tester.widget<Text>(find.text('At least one digit'));
    expect(textWidget3.style?.color, equals(colorPrimary));
  });
  testWidgets('MyHomePage shows password criteria as invalid after focusing on another input', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));

    await tester.enterText(find.byType(TextFormField).at(1), 'Pass');

    await tester.tap(find.byType(TextFormField).at(0));
    await tester.pump();

    final textWidget1 = tester.widget<Text>(find.text('8 characters or more (no spaces)'));
    expect(textWidget1.style?.color, equals(colorErrorBorderColor));

    final textWidget3 = tester.widget<Text>(find.text('At least one digit'));
    expect(textWidget3.style?.color, equals(colorErrorBorderColor));
  });
  testWidgets('MyHomePage shows password criteria as valid when not met', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));

    await tester.enterText(find.byType(TextFormField).at(1), 'password2');

    await tester.pump();

    final textWidget1 = tester.widget<Text>(find.text('8 characters or more (no spaces)'));
    expect(textWidget1.style?.color, equals(colorValidHint));

    final textWidget3 = tester.widget<Text>(find.text('At least one digit'));
    expect(textWidget3.style?.color, equals(colorValidHint));
  });
}
