import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'image_selection_screen.dart';

class SendImageScreen extends StatefulWidget {
  const SendImageScreen(this.type, {super.key});
  final type;

  @override
  _SendImageScreenState createState() => _SendImageScreenState(type);
}

class _SendImageScreenState extends State<SendImageScreen> {
  final TextEditingController _spyInputController = TextEditingController();
  ImagePicker _picker = ImagePicker();
  static var _image;
  String spy = "";
  var type;

  _SendImageScreenState(this.type);

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
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
              XFile? image = await _picker.pickImage(
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
              TextButton(onPressed: () {}, child: const Text("Cancel")),
              TextButton(onPressed: () {}, child: const Text("OK"))
            ],
          )
        ],
      ),
    );
  }
}
