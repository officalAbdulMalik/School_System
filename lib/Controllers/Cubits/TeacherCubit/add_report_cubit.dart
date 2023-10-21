import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/create_report_card.dart';

part 'add_report_state.dart';

class AddReportCubit extends Cubit<AddReportState> {
  AddReportCubit() : super(AddReportInitial());

  addReport({
    required String querterIO,
    required String classId,
    required String sessionID,
    required String subjectID,
    required String comments,
    required List<Map<String, dynamic>> data,
  }) async {
    await Future.delayed(
      const Duration(microseconds: 10),
    );
    emit(AddReportLoading());
    CreateCard.createCard(
            querterIO: querterIO,
            classId: classId,
            sessionID: sessionID,
            subjectID: subjectID,
            comments: comments,
            data1: data)
        .then((value) {
      print(value);
      if (value['success'] == true && value['status'] == 200) {
        emit(AddReportLoaded());
      } else {
        emit(AddReportError(error: value['message']));
      }
    }).catchError((e) {
      emit(AddReportError(error: e.toString()));
      log(e.toString());
      throw e;
    });
  }
}
