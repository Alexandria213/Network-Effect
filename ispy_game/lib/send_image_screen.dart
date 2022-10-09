import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import 'image_selection_screen.dart';
import 'package:ispy_game/game_chat.dart';

class SendImageScreen extends StatefulWidget {
  SendImageScreen(this.type, {super.key, this.imageFile});
  final type;
  final imageFile;

  @override
  _SendImageScreenState createState() => _SendImageScreenState(type);
}

class _SendImageScreenState extends State<SendImageScreen> {
  final TextEditingController _spyInputController = TextEditingController();
  ImagePicker picker = ImagePicker();
  String spy = "";
  var type;
  static var _image;

  File? imageFile;

  _SendImageScreenState(this.type);

  File? getImage() {
    picker.pickImage(source: type).then((file) {
      if (file != null) {
        imageFile = File(file.path);
        return imageFile;
      }
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Preview Message")),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              var source = type == ImageSourceType.camera
                  ? ImageSource.camera
                  : ImageSource.gallery;
              XFile? image = await picker.pickImage(
                  source: source,
                  imageQuality: 50,
                  preferredCameraDevice: CameraDevice.front);
              setState(() {
                _image = File(image!.path);
              });
            },
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(color: Colors.blue[200]),
              child: _image != null
                  ? Image.file(
                      _image,
                      width: 300.0,
                      height: 400.0,
                      fit: BoxFit.fitHeight,
                    )
                  : Container(
                      decoration: BoxDecoration(color: Colors.blue[200]),
                      width: 300,
                      height: 400,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                spy = value;
              });
            },
            controller: _spyInputController,
            decoration: const InputDecoration(label: Text("I spy ...")),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ChatScreen(
                          friend: null,
                        ),
                      ),
                    );
                  },
                  child: const Text("Send"))
            ],
          )
        ],
      ),
    );
  }
}
