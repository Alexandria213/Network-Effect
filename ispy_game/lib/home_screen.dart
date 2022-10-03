import 'package:flutter/material.dart';
import 'package:ispy_game/image_selection_screen.dart';
import 'package:ispy_game/send_image_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Text input window when guessing or responding
  Future<void> _displayTextInputDialog(BuildContext context) async {
    print("Loading Dialog");
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Guess'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // position
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(
                    () {
                      value = value;
                    },
                  );
                },
                //controller: _spyInputController,
                decoration: const InputDecoration(hintText: "Content"),
              ),
              ElevatedButton(
                key: const Key("OKButton"),
                child: const Text('OK'),
                onPressed: () {
                  setState(
                    () {},
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SelectImageScreen(),
                        ),
                      );
                    },
                    child: const Text("Share an Image"),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Respond to a Guess"),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Respond to an Image"),
                  ),
                )
              ],
            ),
            Row(
              children: const [
                Center(
                  child: Text("Game Chat"),
                )
              ],
            )
          ],
        )
        //Game chat,
        );
  }
}
