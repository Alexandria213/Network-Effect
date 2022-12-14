import 'dart:convert';
import 'dart:io';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutex/mutex.dart';

import 'scoring.dart';

const int ourPort = 8888;
final m = Mutex();

class Friends extends Iterable<String> {
  Map<String, Friend> _names2Friends = {};
  Map<String, Friend> _ips2Friends = {};
  Map<int, Friend> _score2Friends = {};
  final Scoring score = Scoring();

  void add(String name, String ip) {
    Friend f = Friend(ipAddr: ip, name: name, score: 0);
    _names2Friends[name] = f;
    _ips2Friends[ip] = f;
    score.friends.add(name);
  }

  String? ipAddr(String? name) => _names2Friends[name]?.ipAddr;

  Friend? getFriend(String? name) => _names2Friends[name];

  int? Score(String? name) => _names2Friends[name]?.score;

  void receiveFrom(String ip, Image message) {
    print("receiveFrom($ip, $message)");
    if (!_ips2Friends.containsKey(ip)) {
      String newFriend = "Friend${_ips2Friends.length}";
      print("Adding new friend");
      add(newFriend, ip);
      print("added $newFriend!");
    }
    _ips2Friends[ip]!.receive(message);
  }

  @override
  Iterator<String> get iterator => _names2Friends.keys.iterator;
}

class Friend extends ChangeNotifier {
  final String ipAddr;
  final String name;
  final List<Message> _messages = [];
  int score;

  Friend({required this.ipAddr, required this.name, required this.score});

  Future<void> send(Image message) async {
    Socket socket = await Socket.connect(ipAddr, ourPort);
    socket.write(message);
    // final imageBytes = await rootBundle.load(image!.path);
    // final bytesAsString = base64Encode(imageBytes.buffer
    //     .asUint8List(imageBytes.offsetInBytes, imageBytes.lengthInBytes));
    // print(bytesAsString);
    // socket.write("$bytesAsString\n");
    socket.close();
    await _add_message("Me", message);
  }

  Future<void> receive(Image message) async {
    return _add_message(name, message);
  }

  Future<void> _add_message(String name, Image message) async {
    await m.protect(
      () async {
        _messages.add(Message(author: name, content: message));
        notifyListeners();
      },
    );
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
            return Row(children: [
              Container(
                alignment: isMe ? Alignment.bottomLeft : Alignment.bottomRight,
                height: 200,
                width: 90,
                child: m.content,
              ),
              SizedBox(
                width: 230,
              ),
              Container(
                  alignment:
                      !isMe ? Alignment.bottomRight : Alignment.bottomLeft,
                  height: 500,
                  width: 90,
                  child: m.content)
            ]);
          })
          .toList()
          // https://stackoverflow.com/questions/53483263/flutter-how-to-make-a-list-that-always-scrolls-to-the-bottom
          .reversed
          .toList(growable: false),
    );
  }
}

class Message {
  final Image content;
  final String author;
  //final String cont;
  const Message({required this.author, required this.content});

  String get transcript => '$author: $content';
}
