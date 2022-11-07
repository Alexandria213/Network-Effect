import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ispy_game/game_chat.dart';

import 'friends.dart';
import 'image_selection_screen.dart';

// getting a directory path for saving
const String path = 'assets/images';

class SendImageScreen extends StatefulWidget {
  const SendImageScreen(this.type, {super.key, required this.friend});
  final type;

  final Friend friend;

  @override
  _SendImageScreenState createState() => _SendImageScreenState(type);
}

class _SendImageScreenState extends State<SendImageScreen> {
  //text editor for caption for image
  final TextEditingController _spyInputController = TextEditingController();
  String spy = "";

  //image, image picker, and image type
  var _picker;
  var type;
  static var _image;

  _SendImageScreenState(this.type);

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(type == ImageSourceType.camera
              ? "Image from Camera"
              : "Image from Gallery")),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile? image = await _picker.pickImage(
                    source: source,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image!.path);
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.blue[200]),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.blue[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
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
            decoration: const InputDecoration(
              label: Text("I spy ..."),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  _image.copy('$path/image1.png');
                  //widget.friend.send(_spyInputController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(friend: widget.friend),
                    ),
                  );
                },
                child: const Text("Send"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
