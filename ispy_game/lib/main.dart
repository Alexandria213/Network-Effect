import 'package:flutter/material.dart';
import 'package:ispy_game/home_screen.dart';

void main() {
  runApp(const EyeSpy());
}

class EyeSpy extends StatelessWidget {
  const EyeSpy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eye Spy',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
