import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

import 'friends.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.friend});

  final Friend? friend;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  Future<void> send(String msg) async {
    await widget.friend!.send(msg).catchError((e) {
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
          children: <Widget>[
            Expanded(child: widget.friend!.bubble_history()),
            MessageBar(onSend: (_) => send(_)),
          ],
        ),
      ),
    );
  }
}
