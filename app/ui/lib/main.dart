import 'package:flutter/material.dart';
import 'package:ui/theme.dart';
import 'package:ui/ui/screens/registration.screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: const MaterialTheme(TextTheme()).light(),
        home: const RegistrationScreen());
  }
}
