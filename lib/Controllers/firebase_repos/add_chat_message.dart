import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseHelper {
  String? userType = LoginApiShadePreference.preferences!.getString('type');

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<void> addFileInChat(
      String docId, chatMessageData, String fileLink) async {
    FirebaseFirestore.instance
        .collection("Chat")
        .doc(docId)
        .collection('chats')
        .add({
      'send_by': userType,
      'message': chatMessageData,
      'time_tempt': DateTime.now(),
      'read': false,
      'download': false,
      "file_path": fileLink,
    });
  }

  Future<void> addChat(String docId, chatMessageData) async {
    FirebaseFirestore.instance
        .collection("Chat")
        .doc(docId)
        .collection('chats')
        .add({
      'send_by': userType,
      'message': chatMessageData,
      'time_tempt': DateTime.now(),
      'read': false,
      "file_path": '',
    });
  }

  Future<String> uploadImage(File imageFile, String imageName) async {
    Reference storageReference =
    FirebaseStorage.instance.ref().child(imageName);
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask;

    if (storageTaskSnapshot.state == TaskState.success) {
      // Image uploaded successfully, return the download URL
      String downloadUrl = await storageReference.getDownloadURL();

      log(downloadUrl);

      return downloadUrl;
    } else {
      // Handle the failure, e.g., show an error message
      throw 'Failed to upload image';
    }
  }

  Future<void> startChat(
      String yourID, outerId, name, String lastName, profileImage) async {
    await FirebaseFirestore.instance
        .collection("Chat")
        .doc(getChatRoomId(yourID, outerId))
        .set({
      'user_id': outerId,
      'user_type': userType,
      'firstName': name,
      'lastName': lastName,
      'profileImage': profileImage,
      // 'read': false,
    });
  }
}
