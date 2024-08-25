import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_task/utils/colors.dart';
import 'package:flutter_test_task/widgets/form.dart';

void main() {
  group('RegistrationForm', () {
    testWidgets('Initial state of the form is correct',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RegistrationForm(),
          ),
        ),
      );
      expect(find.byType(TextFormField), findsNWidgets(2));
      final submitButton = tester.widget<Opacity>(find.byType(Opacity));
      expect(submitButton.opacity, 0.5);
    });

    testWidgets('Password criteria are correctly validated ',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RegistrationForm(),
          ),
        ),
      );
      final emailField = find.byType(TextFormField).at(0);

      final passwordField = find.byType(TextFormField).at(1);

      await tester.enterText(passwordField, 'short');
      await tester.enterText(emailField, 'a@a.a');
      await tester.pump();

      final criteriaTextsBeforeSubmit = find.byType(Text);
      //Check if tips don't validation
      criteriaTextsBeforeSubmit.evaluate().forEach((element) {
        final textWidget = element.widget as Text;
        if (textWidget.data == 'At least one digit' ||
            textWidget.data == '8 characters or more (no spaces)') {
          expect(textWidget.style?.color, equals(colorErrorBorderColor));
        }
      });
      await tester.enterText(passwordField, 'Password1');
      await tester.pump();
      //Check if tips pass validation
      final criteriaTextsAfterSubmit = find.byType(Text);
      criteriaTextsAfterSubmit.evaluate().forEach((element) {
        final textWidget = element.widget as Text;
        if (textWidget.data == 'At least one digit' ||
            textWidget.data == '8 characters or more (no spaces)') {
          expect(textWidget.style?.color, equals(colorValidHint));
        }
      });

      //Check if button  enabled
      final submitButton = tester.widget<Opacity>(find.byType(Opacity));
      expect(submitButton.opacity, 1.0);


    });

    testWidgets('Submit button enables when form is valid',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RegistrationForm(),
          ),
        ),
      );

      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'Password1');
      await tester.pump();

      final submitButton = tester.widget<Opacity>(find.byType(Opacity));
      expect(submitButton.opacity, 1.0);
    });

    testWidgets('Password criteria are validated only after form submission', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RegistrationForm(),
          ),
        ),
      );

      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      await tester.enterText(passwordField, 'Short1');
      await tester.enterText(emailField, 'a@a.a');
      await tester.pump();

      // check default state
      final criteriaText = find.text('Uppercase and lowercase letters');
      expect(tester.widget<Text>(criteriaText).style?.color, equals(colorPrimary));


      await tester.tap(find.text('Sign up'));
      await tester.pump();

      // check validation passed state
      expect(tester.widget<Text>(criteriaText).style?.color, equals(colorValidHint));
      await tester.enterText(passwordField, 'short1');
      await tester.enterText(emailField, 'a@a.a');
      await tester.pump();
      await tester.tap(find.text('Sign up'));
      await tester.pump();

      // check validation failed state
      expect(tester.widget<Text>(criteriaText).style?.color, equals(colorErrorBorderColor));
    });

  });
}
