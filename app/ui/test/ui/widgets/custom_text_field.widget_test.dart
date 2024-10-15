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
  group("CustomTextFieldWidget should render", () {
    testWidgets("with mandatory parameters", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          hintText: 'Email',
        ),
      ));

      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets("with prefix icon", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          hintText: 'Email',
          prefixIcon: Icon(Icons.email),
        ),
      ));

      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets("with suffix icon", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          hintText: 'Password',
          suffixIcon: Icon(Icons.visibility),
        ),
      ));

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets("with obscure text", (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(
        child: const CustomTextFieldWidget(
          hintText: 'Password',
          obscureText: true,
        ),
      ));

      expect(find.byType(TextField), findsOneWidget);
    });
  });
}
