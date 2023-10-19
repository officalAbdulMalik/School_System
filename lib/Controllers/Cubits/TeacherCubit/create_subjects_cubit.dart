import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/assign_subject.dart';
import 'package:school_system/Data/Repository/create_subjects.dart';

part 'create_subjects_state.dart';

class CreateSubjectsCubit extends Cubit<CreateSubjectsState> {
  CreateSubjectsCubit() : super(CreateSubjectsInitial());

  Future addSubjectToClass(
      String classID, String SubjectName, String type, String code) async {
    emit(CreateSubjectsLoading());

    try {
      await CreateSubjectsRepo()
          .createSubjects(SubjectName, classID, type, code)
          .then((value) {
        log(value.toString());

        if (value['error'] != null && value['error'] != true) {
          emit(CreateSubjectsLoaded());
        } else {
          emit(CreateSubjectsError(error: value['message']));
        }
      }).catchError((e) {
        emit(CreateSubjectsError(error: 'Some Thing Wrong Try Again'));
        log(e.toString());
      });
    } catch (e) {
      emit(CreateSubjectsError(error: e.toString()));
    }
  }
}
