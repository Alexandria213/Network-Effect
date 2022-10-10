import 'package:flutter/material.dart';

class Scoring extends StatefulWidget {
  Scoring({super.key});

  //names and scores
  List<String> friends = ["Friend 1", "Friend 2", "Friend 3"];
  Map subtitles = {1: 3, 3: 4, 5: 6};

  int index(String friend) {
    return friends.indexOf(friend);
  }

  @override
  _ScoringState createState() => _ScoringState();
}

class _ScoringState extends State<Scoring> {
  Scoring score = Scoring();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eye Spy"),
      ),
      body: ListView.builder(
        itemCount: score.friends.length,
        itemBuilder: (context, index) {
          return Card(
            key: const Key("CircleCard"),
            child: ListTile(
              onTap: () {},
              title: Text(score.friends[index]),
              subtitle: Row(
                children: [
                  Text(score.subtitles.keys.elementAt(index).toString()),
                  const Text(" : "),
                  Text(score.subtitles.values.elementAt(index).toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
