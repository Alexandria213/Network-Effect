import 'package:flutter/material.dart';
import 'package:ispy_game/main.dart';

class SelectImageScreen extends StatelessWidget {
  const SelectImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Image Source')),
      body: Column(children: [TextButton(onPressed: () {}, child: const Text("Upload Image")), 
      TextButton(onPressed: () {}, child: const Text("Take a Picture"))]
      ),
    );
  }
}
