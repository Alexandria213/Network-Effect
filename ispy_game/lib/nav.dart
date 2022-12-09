// import 'package:flutter/material.dart';
// import 'package:ispy_game/home_screen.dart';
// import 'package:ispy_game/image_selection_screen.dart';
// import 'package:ispy_game/takepictureScreen.dart';
// import 'package:ispy_game/send_image_screen.dart';
// import 'package:ispy_game/scoring.dart';
// import 'package:ispy_game/server.dart';
// import 'package:ispy_game/game_chat.dart';
// import 'package:ispy_game/friends.dart';
// import 'package:ispy_game/main.dart';
// import 'package:ispy_game/caption.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Weather App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const NavigationScaffold());
//   }
// }

// class NavigationScaffold extends StatefulWidget {
//   const NavigationScaffold({super.key});

//   @override
//   State<NavigationScaffold> createState() => _NavigationScaffoldState();
// }

// class _NavigationScaffoldState extends State<NavigationScaffold> {
//   int screenIndex = 0;
//   final screens = [
//     Home(),
//     Scoring(),
//     Caption(),
//   ];

//   void updateScreenIndex(int newScreenIndex) {
//     setState(() {
//       screenIndex = newScreenIndex;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[screenIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: screenIndex,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
//           BottomNavigationBarItem(icon: Icon(Icons.score), label: "Score"),
//           BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share"),
//         ],
//         onTap: updateScreenIndex,
//         selectedItemColor: Color.fromARGB(255, 140, 14, 14),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//     );
//   }
// }
