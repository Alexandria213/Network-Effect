// import 'package:flutter/material.dart';
// import 'package:ispy_game/home_screen.dart';
// import 'dart:async';
// import 'dart:io';
// import 'package:ispy_game/nav.dart';
// // import 'package:camera/camera.dart';

// main() {
//   // Ensure that plugin services are initialized so that `availableCameras()`
//   // can be called before `runApp()`
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const EyeSpy());
// }

// class EyeSpy extends StatelessWidget {
//   const EyeSpy({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Eye Spy',
//       theme: ThemeData(
//         // This is the theme of your application.
//         primarySwatch: Colors.green,
//       ),
//       home: const Home(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ispy_game/home_screen.dart';
import 'package:ispy_game/image_selection_screen.dart';
import 'package:ispy_game/list_friends.dart';
import 'package:ispy_game/takepictureScreen.dart';
import 'package:ispy_game/send_image_screen.dart';
import 'package:ispy_game/scoring.dart';
import 'package:ispy_game/server.dart';
import 'package:ispy_game/game_chat.dart';
import 'package:ispy_game/friends.dart';
import 'package:ispy_game/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const NavigationScaffold());
  }
}

class NavigationScaffold extends StatefulWidget {
  const NavigationScaffold({super.key});

  @override
  State<NavigationScaffold> createState() => _NavigationScaffoldState();
}

class _NavigationScaffoldState extends State<NavigationScaffold> {
  int screenIndex = 0;
  final screens = [
    Home(),
    Scoring(),
    Server(),
    // SendImageScreen(),
  ];

  void updateScreenIndex(int newScreenIndex) {
    setState(() {
      screenIndex = newScreenIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Server"),
          BottomNavigationBarItem(icon: Icon(Icons.score), label: "Score"),

          // BottomNavigationBarItem(icon: Icon(Icons.image), label: "SendImage"),
        ],
        onTap: updateScreenIndex,
        selectedItemColor: Color.fromARGB(255, 140, 14, 14),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
