import 'package:flutter/material.dart';
import 'package:ispy_game/send_image_screen.dart';

enum ImageSourceType { gallery, camera }

class SelectImageScreen extends StatelessWidget {
  const SelectImageScreen({super.key});

  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SendImageScreen(type)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Selection"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                key: const Key("GalleryButton"),
                color: Colors.green,
                child: const Text(
                  "Pick Image!",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _handleURLButtonPress(context, ImageSourceType.gallery);
                },
              ),
              MaterialButton(
                key: const Key("CameraButton"),
                color: Colors.green,
                child: const Text(
                  "Take a Picture!",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _handleURLButtonPress(context, ImageSourceType.camera);
                },
              ),
            ],
          ),
        ));
  }
}
