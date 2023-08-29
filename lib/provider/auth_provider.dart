import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:qchat/features/models/chat_details_model.dart';
import '../features/models/chat_user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthProvider {
  var verificationId = ''.obs;

  // authentication user
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for storing self user information
  static chatUserModel? me;

  // get user data
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // cloud storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // return current user
  static User get user => auth.currentUser!;

  // check if user exists or not exists
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // get current user information
  static Future<void> getSelfInformation() async {
    await firestore.collection('users').doc(user.uid).get().then((value) async {
      if (value.exists) {
        me = chatUserModel.fromJson(value.data()!);
      } else {
        await userCreate().then((value) => {getSelfInformation()});
      }
    });
  }

  // create a new user
  static Future<void> userCreate() async {
    // current time
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatModel = chatUserModel(
      uid: user.uid,
      name: user.displayName,
      image: user.photoURL,
      email: user.email,
      about: 'By Nthach',
      createAt: time,
      lastOnline: time,
      pushToken: '',
      age: '19',
      isOnline: true,
      phone: '',
      dateOfBirth: null,
    );
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatModel.toJson());
  }

  // get all users is not my account
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('uid', isNotEqualTo: user.uid)
        .snapshots();
  }

  // update profile user
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me!.name,
      'phone': me!.phone,
      'about': me!.about,
      'dateOfBirth': me!.dateOfBirth,
    });
  }

  // update profile picture for user
  static Future<void> updateProfilePicture(File file) async {
    // This will get the filename with file extension
    final ext = file.path.split('.').last;

    // storage file with path
    final ref = storage.ref().child('profie_picture/${user.uid}.$ext');

    //Use putFile method to upload the File
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then(
        (p0) => {log('Data transferred:  ${p0.bytesTransferred / 1000} KB')});

    // updating image in firestore database
    me!.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me!.image});
  }

  // getting spefific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      chatUserModel model) {
    return firestore
        .collection('users')
        .where('uid', isEqualTo: model.uid)
        .snapshots();
  }

  // update user status of the user
  static Future<void> updateStatusUser(bool isOnline) async {
    return await firestore.collection('users').doc(user.uid).update({
      'isOnline': isOnline,
      'lastOnline': DateTime.now().millisecondsSinceEpoch.toString(),
      'pushToken': me?.pushToken,
    });
  }

  // ****************************************** CHAT SCREEN APIs ****************************************

  // create string convesation id
  static String getConvesationId(String id) =>
      user.uid.hashCode <= id.hashCode // compare hash code
          ? '${user.uid}_$id'
          : '${id}_${user.uid}';

  // getting all messages of specific conversation from firebase database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      chatUserModel userModel) {
    return firestore
        .collection('chats/${getConvesationId(userModel.uid!)}/messages/')
        .snapshots();
  }

  // sending messages
  static Future<void> sendMessages(
      chatUserModel userModel, String msg, Type type) async {
    // current time
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    // mess to send
    final messModel = messagesModel(
        msg: msg,
        type: type,
        from_name: user.displayName!,
        from_uid: user.uid,
        last_time: '',
        to_name: userModel.name!,
        to_uid: userModel.uid!,
        time_sent: time);

    return await firestore
        .collection('chats/${getConvesationId(userModel.uid!)}/messages/')
        .doc(messModel.time_sent)
        .set(messModel.toJson())
        .then((value) => sendMessagesNotifications(
            userModel, type == Type.text ? msg : 'imges'));
  }

  // update status of last message
  static Future<void> updateLastMessage(messagesModel mess) async {
    try {
      return await firestore
          .collection('chats/${getConvesationId(mess.from_uid)}/messages/')
          .doc(mess.time_sent)
          .update(
              {'last_time': DateTime.now().millisecondsSinceEpoch.toString()});
    } catch (e) {
      return null;
    }
  }

  // get last message from user
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      chatUserModel userModel) {
    return FirebaseFirestore.instance
        .collection('chats/${getConvesationId(userModel.uid!)}/messages/')
        .orderBy('time_sent',
            descending: true) // Sort by timestamp in descending order
        .limit(1) // Limit to only one result (the most recent message)
        .snapshots();
  }

  // send messages image
  static Future<void> sendMessagesImage(
      chatUserModel userModel, File file) async {
    // This will get the filename with file extension
    final ext = file.path.split('.').last;

    // storage file with path
    final ref = storage.ref().child(
        'images/${getConvesationId(userModel.uid!)}/${DateTime.now().millisecondsSinceEpoch.toString()}.$ext');

    //Use putFile method to upload the File
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then(
        (p0) => {log('Data transferred:  ${p0.bytesTransferred / 1000} KB')});

    // updating image in firestore database
    final imageURL = await ref.getDownloadURL(); // url image from storage
    await sendMessages(
        userModel, imageURL, Type.image); // send messages with image type
  }

  // ****************************************** Push notifications ****************************************

  // for accessing firebase messages (Push notifications)
  static FirebaseMessaging FCMmessaging = FirebaseMessaging.instance;

  //  for getting token notifications
  static Future<void> FCMtoken() async {
    await FCMmessaging.requestPermission();
    await FCMmessaging.getToken().then((value) {
      me?.pushToken = value;
      log('TOKEN: ${value}');
    });
  }

  // for send notifications
  static Future sendMessagesNotifications(
      chatUserModel userModel, String msg) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    final body = {
      "to": userModel.pushToken,
      "notification": {
        "body": msg,
        "OrganizationId": "2",
        "content_available": true,
        "priority": "high",
        "subtitle": "Elementary School",
        "title": me?.name,
      },
      "data": {
        "priority": "high",
        "sound": "app_sound.wav",
        "content_available": true,
        "bodyText": msg,
        "organization": "Elementary school"
      }
    };
    try {
      final result = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer AAAA_ZuoDbk:APA91bEnJO4dhwXreSIPV0J3qmj1ppTuKgO-_uF8nW6XEGXUq2dFBOfDXHBxFHyjtOWa3mzCAzvZ5z4moPVKiFMIxVhgy6cln0mvFyyNB0M5eW3XlSqMgolYRAUXDbow8fYW_Q0izvZy'
        },
      );
      log('${result.body}');
      return jsonDecode(result.body);
    } catch (e) {
      print(e);
      return 'error $e';
    }
  }
}
