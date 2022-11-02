import 'package:flutter/material.dart';
import 'package:ispy_game/home_screen.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';

main() {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();
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
        primarySwatch: Colors.green,
      ),
      home: const Home(),
    );
  }
}
