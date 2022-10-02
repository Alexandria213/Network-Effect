import 'package:flutter/material.dart';
import 'package:ispy_game/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(children:[Row(
        children: [Expanded(child: TextButton(onPressed: (){}, child: const Text("Share an Image"))), 
        Expanded(child: TextButton(onPressed: (){}, child: const Text("Resond to a Guess"))),
        Expanded(child: TextButton(onPressed: (){}, child: const Text("Respond to an Image")))
        ]),
        Row(children:[Center(child: Text("Game Chat"))])]
        )
        //Game chat,
    );
  }
}
