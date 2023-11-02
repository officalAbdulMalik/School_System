import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Controllers/firebase_repos/add_chat_message.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit() : super(CreateChatInitial());

  createChat(String yourId, String outerId, String firstName, String lastName,
      String profileImage) async {
    await Future.delayed(Duration.zero);

    emit(CreateChatLoading());

    await FirebaseHelper()
        .startChat(yourId, outerId, firstName, lastName, profileImage)
        .then((value) {
      emit(CreateChatLoaded());
    }).catchError((e) {
      emit(CreateChatError(error: e.toString()));
    });
  }

  addFileInChat(String docID, String chatMessage, String filepath) async {
    await Future.delayed(Duration.zero);

    emit(CreateChatLoading());

    await FirebaseHelper()
        .uploadImage(File(filepath), DateTime.now().toString())
        .then((value) {
      FirebaseHelper().addFileInChat(docID, chatMessage, value).then((value) {
        emit(CreateChatLoaded());
      });
    }).catchError((e) {
      emit(CreateChatError(error: e.toString()));
    });
  }
}
