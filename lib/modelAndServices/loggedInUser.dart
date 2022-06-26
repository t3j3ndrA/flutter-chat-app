import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chat_application/toasts/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

class LoggedInUser extends ChangeNotifier {
  String firstName = '';
  String lastName = '';
  String avatarImage = '';
  String password = '';
  String eMail = '';
  String uid = '';
  final _authInstance = FirebaseAuth.instance;
  final _userDbInstance = FirebaseFirestore.instance.collection('users');
  final _storageRef = FirebaseStorage.instance.ref();

  updateUserData(LoggedInUser loggedInUser) async {
    Map<String, dynamic> data = {
      'firstName': loggedInUser.firstName,
      'lastName': loggedInUser.lastName,
      'avatarImage': loggedInUser.avatarImage,
    };
    await _userDbInstance
        .doc(loggedInUser.uid)
        .set(data, SetOptions(merge: true));
  }

  listenForLoggedInUser(LoggedInUser loggedInUser) async {
    _userDbInstance.doc(loggedInUser.uid).snapshots().listen((event) {
      final newUsersData = event.data() as Map<String, dynamic>;
      loggedInUser.firstName = newUsersData['firstName'];
      loggedInUser.lastName = newUsersData['lastName'];
      loggedInUser.avatarImage = newUsersData['avatarImage'];

      notifyListeners();
    });
  }

  signInWithEmailAndPassword(LoggedInUser loggedInUser) async {
    try {
      final loggedInData = await _authInstance.signInWithEmailAndPassword(
          email: loggedInUser.eMail, password: loggedInUser.password);
      loggedInUser.uid = loggedInData.user!.uid;
      showSuccessToast(msg: 'User Signed In');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showFailureToast(msg: 'No user found for that E-mail');
      } else if (e.code == 'wrong-password') {
        showFailureToast(msg: 'Wrong Credentials');
      }
      return false;
    }

    listenForLoggedInUser(loggedInUser);
    return true;
  }

  void signOutUser(LoggedInUser loggedInUser) async {
    await _authInstance.signOut();

    loggedInUser = LoggedInUser();
    notifyListeners();
  }

  Future<bool> registerUserWithEmailAndPassword(LoggedInUser newUser) async {
    UserCredential registeredUser;
    try {
      registeredUser = await _authInstance.createUserWithEmailAndPassword(
          email: newUser.eMail, password: newUser.password);

      newUser.uid = registeredUser.user!.uid;
      showSuccessToast(msg: 'User registered.');
    } on FirebaseAuthException catch (e) {
      showFailureToast(msg: e.code);
      return false;
    }

    Map<String, dynamic> data = {
      'firstName': newUser.firstName,
      'lastName': newUser.lastName,
      'email': newUser.eMail,
      'password': newUser.password,
      'uid': registeredUser.user!.uid,
      'avatarImage': newUser.avatarImage != ''
          ? newUser.avatarImage
          : 'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg',
    };

    await _userDbInstance.doc(newUser.uid).set(data);
    listenForLoggedInUser(newUser);
    notifyListeners();
    return true;
  }

  void uploadAFile(
      {required LoggedInUser loggedInUser, required File imageFile}) async {
    // print(DateTime.fromMicrosecondsSinceEpoch(1000000000202));
    String fileName = imageFile.path.split('/').last;
    Reference imageReference =
        _storageRef.child('${loggedInUser.uid}/${fileName}');
    try {
      final data = await imageReference.putFile(imageFile);
      print('${(data.bytesTransferred / data.totalBytes) * 100} % Uploaded...');
      loggedInUser.avatarImage = await imageReference.getDownloadURL();
      await _userDbInstance.doc(loggedInUser.uid).set(
          {'avatarImage': loggedInUser.avatarImage}, SetOptions(merge: true));
      showSuccessToast(msg: 'Profile picture updated');
    } on FirebaseException catch (e) {
      showFailureToast(msg: 'Profile picture upload failed!');
    }
  }
}
