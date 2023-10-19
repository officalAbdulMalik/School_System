import 'package:cloud_firestore/cloud_firestore.dart';

class Helper {
  static getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  static Future<void> startChat(
      String chatPid, chatTid, chatMessageData) async {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(getChatRoomId('22', '221'))
        .collection('chats')
        .add({
      'send_by': 'customer',
      'message': chatMessageData,
      'time_tempt': DateTime.now(),
    });
  }
}
