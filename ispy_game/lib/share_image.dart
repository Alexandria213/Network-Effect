import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ispy_game/home_screen.dart';
import 'package:ispy_game/image_selection_screen.dart';
import 'package:ispy_game/takepictureScreen.dart';
import 'package:ispy_game/send_image_screen.dart';
import 'package:ispy_game/scoring.dart';
import 'package:ispy_game/server.dart';
import 'package:ispy_game/game_chat.dart';
import 'package:ispy_game/friends.dart';
import 'package:ispy_game/main.dart';

void main() {
  runApp(const ShareImage());
}

class ShareImage extends StatefulWidget {
  const ShareImage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ShareImage> {
  File? file;
  List<String> images = [];
  ImagePicker image = ImagePicker();
  final TextEditingController emailController = new TextEditingController();
  getImage() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      images.add(img.path);
    });
  }

  void share(BuildContext context) async {
    if (file != null) {
      await Share.shareFiles(
        images,
        text: emailController.text,
      );
    } else {
      await Share.share(
        emailController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'share app',
      color: Colors.green,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Share Images and Caption',
            selectionColor: Colors.green,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.black12,
                  child: file == null
                      ? IconButton(
                          onPressed: () {
                            getImage();
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                        )
                      : Image.file(
                          file!,
                          fit: BoxFit.fill,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Text',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    share(context);
                  },
                  color: Colors.green,
                  child: const Text(
                    'Share >',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
