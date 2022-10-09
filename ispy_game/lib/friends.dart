import 'dart:io';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:mutex/mutex.dart';

const int ourPort = 8888;
final m = Mutex();

class Friends extends Iterable<String> {
  Map<String, Friend> _names2Friends = {};
  Map<String, Friend> _ips2Friends = {};

  void add(String name, String ip) {
    Friend f = Friend(ipAddr: ip, name: name);
    _names2Friends[name] = f;
    _ips2Friends[ip] = f;
  }

  String? ipAddr(String? name) => _names2Friends[name]?.ipAddr;

  Friend? getFriend(String? name) => _names2Friends[name];

  void receiveFrom(String ip, String message) {
    print("receiveFrom($ip, $message)");
    if (!_ips2Friends.containsKey(ip)) {
      String newFriend = "Friend${_ips2Friends.length}";
      print("Adding new friend");
      add(newFriend, ip);
      print("added $newFriend!");
    }
    _ips2Friends[ip]!.receive(message);

    // if (image == null) {
    //   _ips2Friends[ip]!.receive(message);
    // } else {
    //   _ips2Friends[ip]!.receivePic(message, image);
    // }
  }

  @override
  Iterator<String> get iterator => _names2Friends.keys.iterator;
}

class Friend extends ChangeNotifier {
  final String ipAddr;
  final String name;
  final List<Message> _messages = [];

  Friend({required this.ipAddr, required this.name});

  Future<void> sendPic(String message, File? image) async {
    Socket socket = await Socket.connect(ipAddr, ourPort);
    socket.write(message);
    Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: Colors.blue[200]),
      child: image != null
          ? Image.file(
              image,
              width: 50.0,
              height: 50.0,
              fit: BoxFit.fitHeight,
            )
          : Container(
              decoration: BoxDecoration(color: Colors.blue[200]),
              width: 50,
              height: 50,
              child: Icon(
                Icons.camera_alt,
                color: Colors.grey[800],
              ),
            ),
    );
    socket.close();
    await _add_message_and_pic("Me", message, image);
  }

  Future<void> receive(String message) async {
    return _add_message(name, message);
  }

  Future<void> receivePic(String message, File? image) async {
    return _add_message(name, message);
  }

  Future<void> _add_message(String name, String message) async {
    await m.protect(() async {
      _messages.add(Message(author: name, content: message));
      notifyListeners();
    });
  }

  Future<void> _add_message_and_pic(
      String name, String message, File? image) async {
    await m.protect(() async {
      _messages.add(Message(author: name, content: message, image: image));
      notifyListeners();
    });
  }

  String history() => _messages
      .map((m) => m.transcript)
      .fold("", (message, line) => '$message\n$line');

  Widget bubble_history() {
    return ListView(
      reverse: true,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: _messages
          .map((m) {
            bool isMe = m.author == "Me";
            return BubbleNormal(
              text: m.content,
              isSender: isMe,
              color: isMe ? const Color(0xFFE8E8EE) : const Color(0xFF1B97F3),
              tail: false,
              textStyle: isMe
                  ? const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    )
                  : const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
            );
          })
          .toList()
          // https://stackoverflow.com/questions/53483263/flutter-how-to-make-a-list-that-always-scrolls-to-the-bottom
          .reversed
          .toList(growable: false),
    );
  }
}

class Message {
  final String content;
  final String author;
  final File? image;

  const Message({required this.author, required this.content, this.image});

  String get transcript => '$author: $content';
}
