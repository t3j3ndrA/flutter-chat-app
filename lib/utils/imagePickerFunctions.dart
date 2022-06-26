import 'dart:io';
import 'package:chat_application/modelAndServices/loggedInUser.dart';
import 'package:chat_application/toasts/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final galleryImagePickedAction = (LoggedInUser loggedInUser) async {
  XFile? imagePicked =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (imagePicked != null) {
    loggedInUser.uploadAFile(
        loggedInUser: loggedInUser, imageFile: File(imagePicked.path));
    showSuccessToast(msg: 'Updating Profile Picture...');
  }
};

final cameraImagePickedAction = (LoggedInUser loggedInUser) async {
  XFile? imagePicked =
      await ImagePicker().pickImage(source: ImageSource.camera);
  if (imagePicked != null) {
    loggedInUser.uploadAFile(
        loggedInUser: loggedInUser, imageFile: File(imagePicked.path));
    showSuccessToast(msg: 'Updating Profile Picture...');
  }
};
