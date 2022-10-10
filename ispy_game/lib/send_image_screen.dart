import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image_selection_screen.dart';
import 'package:ispy_game/game_chat.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class SendImageScreen extends StatefulWidget {
  const SendImageScreen({this.type, super.key, this.imageFile});
  final type;
  final imageFile;

  File? get image {
    return imageFile;
  }

  @override
  _SendImageScreenState createState() => _SendImageScreenState();
}

class _SendImageScreenState extends State<SendImageScreen> {
  final TextEditingController _spyInputController = TextEditingController();
  ImagePicker picker = ImagePicker();
  String spy = "";
  var type;
  static var _image;

  File? imageFile;

  _SendImageScreenState();

  uploadImage(File image) async {
    final _firebaseStorage = FirebaseStorage.instance;
    var imagePath = image.path;

    String imageName = imagePath.substring(
        imagePath.lastIndexOf("/") + 1, imagePath.lastIndexOf("."));
    String path = imagePath.substring(
        imagePath.indexOf("/") + 1, imagePath.lastIndexOf("/"));

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      var file = File(image.path);

      //Upload to Firebase
      TaskSnapshot taskSnapshot =
          await _firebaseStorage.ref('$path/$imageName').putFile(file);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        downloadUrl = imageFile as String;
      });
    } else {
      print('Permission not granted. Try Again with permission access');
    }
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
              File? image = (await picker.pickImage(
                  source: source,
                  imageQuality: 50,
                  preferredCameraDevice: CameraDevice.front)) as File?;
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
                    uploadImage(_image);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("Send"))
            ],
          )
        ],
      ),
    );
  }
}
