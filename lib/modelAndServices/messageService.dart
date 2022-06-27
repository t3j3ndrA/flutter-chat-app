import 'package:chat_application/modelAndServices/conversations.dart';
import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageService {
  final _authInstance = FirebaseAuth.instance;
  final _userDbInstance = FirebaseFirestore.instance.collection('users');
  final _messageDbInstance = FirebaseFirestore.instance.collection('messages');

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
      conversations.noticeStatesUpdated();
    });
  }
}
