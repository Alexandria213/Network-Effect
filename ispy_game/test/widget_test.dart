/* Citations: 
  Pub.Dev Github Repository (https://github.com/fluttercommunity/plus_plugins/blob/main/packages/sensors_plus/sensors_plus/test/sensors_test.dart)
  */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// added class for image picker from pub dev
import 'package:image_picker/image_picker.dart';

import 'package:ispy_game/friends.dart';
import 'package:ispy_game/game_chat.dart';
import 'package:ispy_game/home_screen.dart';
import 'package:ispy_game/image_selection_screen.dart';
import 'package:ispy_game/list_friends.dart';
import 'package:ispy_game/scoring.dart';
import 'package:ispy_game/send_image_screen.dart';
import 'package:ispy_game/server.dart';

void main() {
  testWidgets('Home Page has 2 buttons', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Home()));

    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });
  testWidgets('Start Game has add friend button and list', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Server()));

    expect(find.byType(FriendListItem), findsOneWidget);
    expect(find.byKey(const Key("AddFriend")), findsOneWidget);
  });
  testWidgets('Scoring page works', (tester) async {
    await tester.pumpWidget(MaterialApp(home: Scoring()));
  });
  testWidgets('Add Friend and check buttons', (tester) async {
    // add friend
    await tester.pumpWidget(MaterialApp(home: Server()));
    Friends().add("Friend", "0000");
    // check if friend is there
    await tester.pumpWidget(
      MaterialApp(
        home: ChatScreen(
          friend: Friend(ipAddr: "0000", name: "Friend"),
        ),
      ),
    );
    // check for Send Image button and guess button
    expect(find.byType(TextButton), findsNWidgets(2));
  });

  test('ImagePicker and gallery type check', () {
    // check both image sources
    ImagePicker imgpick = ImagePicker();

    var source = ImageSource.camera;

    imgpick.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);

    var source2 = ImageSource.gallery;

    imgpick.pickImage(
        source: source2,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
  });

  test('SendImageScreen and camera type check', () {
    var type = ImageSourceType.camera;

    SendImageScreen imageFromGallery = SendImageScreen(type);
    expect(type, ImageSourceType.camera);

    var type2 = ImageSourceType.gallery;

    SendImageScreen imageFromGallery2 = SendImageScreen(type2);
    expect(type2, ImageSourceType.gallery);
  });
}
