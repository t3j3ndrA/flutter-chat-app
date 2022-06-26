import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_application/toasts/toast.dart';

class Conversations extends ChangeNotifier {
  final _authInstance = FirebaseAuth.instance;
  final _userDbInstance = FirebaseFirestore.instance.collection('users');
  final _messageDbInstance = FirebaseFirestore.instance.collection('messages');

  String loggedInUserId = '';
  Map<String, dynamic> allConversations = {};
  List<Map<String, dynamic>> homeScreenAllMessagesList = [];

  getUserByUid(String uid) async {
    final data = await _userDbInstance.doc(uid).get();
    return data.data() as Map;
  }

  listenForAllConversations(
      {required LoggedInUser loggedInUser,
      required Conversations conversations}) async {
    conversations.loggedInUserId = loggedInUser.uid;

    _messageDbInstance
        .doc(conversations.loggedInUserId)
        .snapshots()
        .listen((event) async {
      final newUsersData = event.data() as Map<String, dynamic>;

      conversations.allConversations = newUsersData;

      List<Map<String, dynamic>> newList = [];

      for (var entry in conversations.allConversations.entries) {
        final user = await getUserByUid(entry.key);
        newList.add(<String, dynamic>{'firstName': user['firstName']});
      }
      conversations.homeScreenAllMessagesList = newList;
      print('from listener : ');
      print(conversations.homeScreenAllMessagesList);
      notifyListeners();
    });
  }

  startNewConversationByEmail(
      {required LoggedInUser loggedInUser,
      required String recieversEmail}) async {
    loggedInUserId = loggedInUser.uid;

    final reciverData = await _userDbInstance
        .where(
          'email',
          isEqualTo: recieversEmail,
        )
        .limit(1)
        .get();
    final recivedUser = reciverData.docs.length != 0
        ? reciverData.docs[0].data() as Map<String, dynamic>
        : null;
    if (recivedUser == null) {
      showFailureToast(msg: 'No user exist with this email');
      return;
    }

    await _messageDbInstance
        .doc(loggedInUserId)
        .set({}, SetOptions(merge: true));
    final conversations = await _messageDbInstance.doc(loggedInUserId).get();
    final converSationsData = conversations.data() as Map<String, dynamic>;
    if (converSationsData[recivedUser['uid']] == null) {
      await _messageDbInstance
          .doc(loggedInUserId)
          .set({'${recivedUser['uid']}': []}, SetOptions(merge: true));
      showSuccessToast(msg: 'Conversation added.');
    } else {
      showFailureToast(msg: 'User already exists.');
    }
  }
}
