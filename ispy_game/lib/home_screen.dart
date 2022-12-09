import 'package:flutter/material.dart';
import 'package:ispy_game/scoring.dart';
import 'package:ispy_game/server.dart';
import 'package:ispy_game/nav.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Eye Spy"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                key: const Key("PlayGameButton"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Server(),
                    ),
                  );
                },
                child: const Text('Play Game'),
              ),
              ElevatedButton(
                key: const Key("ScoringButton"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scoring(),
                    ),
                  );
                },
                child: const Text('Scores'),
              ),
              
            ],
          ),
        ));
  }
}
