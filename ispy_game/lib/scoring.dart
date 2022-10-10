import 'package:flutter/material.dart';
import 'package:ispy_game/server.dart';

import 'package:ispy_game/friends.dart';

class Scoring extends StatefulWidget {
  const Scoring({super.key});

  @override
  _ScoringState createState() => _ScoringState();
}

class _ScoringState extends State<Scoring> {
  //names and scores
  List<String> titles = ["Friend 1", "Friend 2", "Friend 3"];
  final subtitles = ["Points:", "Points:", "Points:"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eye Spy"),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Card(
            key: const Key("CircleCard"),
            child: ListTile(
              onTap: () {
                //setState();
              },
              title: Text(titles[index]),
              subtitle: Text(subtitles[index]),
            ),
          );
        },
      ),
    );
  }
}
