import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/ui/widgets/custom_text_field.widget.dart';

// Utility function to create a MaterialApp widget
Widget makeTestableWidget({required Widget child}) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}

void main() {
  group("CustomTextFieldWidget", () {
    // Rendering Tests
    testWidgets("renders with mandatory parameters (labelText)",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Email',
        ),
      ));

      expect(find.text('Email'), findsOneWidget); // Label text is rendered
    });

    testWidgets("renders with hintText", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Email',
          hintText: 'e.g., john.doe@example.com',
        ),
      ));

      expect(find.text('e.g., john.doe@example.com'),
          findsOneWidget); // Hint text is rendered
    });

    testWidgets("renders with prefix icon", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Email',
          prefixIcon: Icons.email,
        ),
      ));

      expect(
          find.byIcon(Icons.email), findsOneWidget); // Prefix icon is rendered
    });

    testWidgets("renders with suffix icon", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Password',
          suffixIcon: Icons.visibility,
        ),
      ));

      expect(find.byIcon(Icons.visibility),
          findsOneWidget); // Suffix icon is rendered
    });

    // Interaction Tests
    testWidgets("renders with obscure text (password)",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Password',
          obscureText: true,
        ),
      ));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue); // TextField is obscured
    });

    testWidgets("toggles obscure text when suffix icon is pressed",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Password',
          obscureText: true,
          suffixIcon: Icons.visibility_off,
        ),
      ));

      // Verify that the password field starts as obscured
      expect(
          tester.widget<TextField>(find.byType(TextField)).obscureText, isTrue);

      // Tap the visibility icon
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pumpAndSettle();

      // Verify that the password field is now visible
      expect(tester.widget<TextField>(find.byType(TextField)).obscureText,
          isFalse);
    });

    testWidgets("accepts text input", (WidgetTester tester) async {
      final textController = TextEditingController();

      await tester.pumpWidget(makeTestableWidget(
        child: CustomTextFieldWidget(
          labelText: 'Email',
          controller: textController,
        ),
      ));

      await tester.enterText(find.byType(TextField), 'test@example.com');
      expect(
          textController.text, 'test@example.com'); // Ensure text input works
    });

    // Disabled State Test
    testWidgets("renders disabled state", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Email',
          enabled: false,
        ),
      ));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse); // TextField is disabled
    });

    // Validation and Error State Tests
    testWidgets("renders with error text", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Email',
          errorText: 'Invalid email address',
        ),
      ));

      expect(find.text('Invalid email address'),
          findsOneWidget); // Error text is rendered
    });

    testWidgets("renders with helper text", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Email',
          helperText: 'Please enter a valid email',
        ),
      ));

      expect(find.text('Please enter a valid email'),
          findsOneWidget); // Helper text is rendered
    });

    // Test for obscured confirm password field toggle
    testWidgets(
        "toggles confirm password obscure text when suffix icon is pressed",
        (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          labelText: 'Confirm Password',
          obscureText: true,
          suffixIcon: Icons.visibility_off,
        ),
      ));

      // Verify that the confirm password field starts as obscured
      expect(
          tester.widget<TextField>(find.byType(TextField)).obscureText, isTrue);

      // Tap the visibility icon
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pumpAndSettle();

      // Verify that the confirm password field is now visible
      expect(tester.widget<TextField>(find.byType(TextField)).obscureText,
          isFalse);
    });
  });
}
