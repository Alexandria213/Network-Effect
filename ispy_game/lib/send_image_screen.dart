import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ispy_game/main.dart';

class SendImageScreen extends StatefulWidget {
  const SendImageScreen({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<SendImageScreen> createState() => _SendImageScreenState();
}

class _SendImageScreenState extends State<SendImageScreen> {
  final TextEditingController _spyInputController = TextEditingController();
  String spy = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Message")),
      body: Column(
        children: [
          Image.file(File(widget.imagePath)),
          TextField(
            onChanged: (value) {
              setState(() {
                spy = value;
              });
            },
            controller: _spyInputController,
            decoration: const InputDecoration(label: Text("I spy ...")),
          ),
          Row(children: [TextButton(onPressed: () {}, child: const Text("Cancel")),
          TextButton(onPressed: () {}, child: const Text("OK"))],)
        ],
      ),
    );
  }
}
