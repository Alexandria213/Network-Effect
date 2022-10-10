import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ispy_game/friends.dart';
import 'package:ispy_game/game_chat.dart';
import 'package:ispy_game/server.dart';

import 'image_selection_screen.dart';

// getting a directory path for saving
const String path = 'assets/images';

class SendImageScreen extends StatefulWidget {
  const SendImageScreen(this.type, {super.key});
  final type;

  @override
  _SendImageScreenState createState() => _SendImageScreenState(type);
}

class _SendImageScreenState extends State<SendImageScreen> {
  //text editor for caption for image
  final TextEditingController _spyInputController = TextEditingController();
  String spy = "";

  //access friend information
  final Friends friends = Friends();
  final Server server = const Server();
  late final Friend friend = Friend(ipAddr: "friends.ipAddr(name)", name: "");

  //chat information
  late final ChatScreen chat = ChatScreen(friend: friend);

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
        title: const Text("Preview Message"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              var source = type == ImageSourceType.camera
                  ? ImageSource.camera
                  : ImageSource.gallery;
              File? image = (await _picker.pickImage(
                  source: source,
                  imageQuality: 50,
                  preferredCameraDevice: CameraDevice.front)) as File?;
              // copy the file to a new path
              final File newImage = await image!.copy('$path/image1');
              setState(() {
                _image = File(image.path);
                _image = newImage;
              });
            },
            child: Container(
              width: 300,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.blue[200],
              ),
              child: _image != null
                  ? Image.file(
                      _image,
                      width: 300.0,
                      height: 400.0,
                      fit: BoxFit.fitHeight,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                      ),
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
            decoration: const InputDecoration(
              label: Text("I spy ..."),
            ),
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
                    friend.send(_spyInputController.text, _image);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => chat),
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
