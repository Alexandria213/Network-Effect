import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

import 'package:ispy_game/image_selection_screen.dart';
import 'friends.dart';

import 'package:ispy_game/send_image_screen.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.friend});

  final Friend? friend;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final SendImageScreen imgscreen = const SendImageScreen();
  static const List<String> list = <String>['Correct', 'Incorrect'];
  String dropdownValue = list.first;

  // Text input window when guessing or responding
  Future<void> _displayRespondToGuessDialog(BuildContext context) async {
    print("Loading Dialog");
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Respond to Guess'),
          content: Column(
            children: [
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                key: const Key("CancelButtonDropdown"),
                child: const Text('Cancel'),
                onPressed: () {
                  setState(
                    () {
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              ElevatedButton(
                key: const Key("OKButtonDropdown"),
                child: const Text('OK'),
                onPressed: () {
                  setState(
                    () {
                      send(dropdownValue, null);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void initState() {
    super.initState();
    widget.friend!.addListener(update);
  }

  void dispose() {
    widget.friend!.removeListener(update);
    print("Goodbye");
    super.dispose();
  }

  void update() {
    print("New message!");
    setState(() {});
  }

  Future<void> send(String msg, File? image) async {
    await widget.friend!.send(msg, image).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $e"),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat with ${widget.friend!.name}"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
                    onPressed: () {
                      _displayRespondToGuessDialog(context);
                    },
                    child: const Text("Respond to a Guess"),
                  ),
                ),
              ],
            ),
            Expanded(child: widget.friend!.bubble_history()),
            MessageBar(onSend: (_) => send(_, imgscreen.image)),
          ],
        ),
      ),
    );
  }
}
