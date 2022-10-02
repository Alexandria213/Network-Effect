import 'package:flutter/material.dart';
import 'package:ispy_game/home_screen.dart';
import 'package:ispy_game/image_selection_screen.dart';
import 'package:ispy_game/send_image_screen.dart';

void main() {
  runApp(EyeSpy());
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
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
