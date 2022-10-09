import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

import 'package:ispy_game/image_selection_screen.dart';
import 'friends.dart';

import 'package:ispy_game/send_image_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.friend});

  final Friend? friend;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  Future<void> sendPic(String msg, File? image) async {
    await widget.friend!.sendPic(msg, image).catchError((e) {
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
                      _displayTextInputDialog(context);
                    },
                    child: const Text("Respond to a Guess"),
                  ),
                ),
              ],
            ),
            Expanded(child: widget.friend!.bubble_history()),

            //NEED ACCESS TO THE IMAGE TO SEND IN THE sendPic method
            //MessageBar(onSend: (_) => sendPic(_, SendImageScreen(type).imageFile)
          ],
        ),
      ),
    );
  }
}
