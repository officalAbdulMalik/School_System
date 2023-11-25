import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_teacher_class.dart';

import 'package:school_system/Models/TeacherModels/teacher_classes.dart';

part 'show_teacher_class_state.dart';

class ShowTeacherClassCubit extends Cubit<ShowTeacherClassState> {
  ShowTeacherClassCubit() : super(ShowTeacherClassInitial());

  Future getClasses() async {
    print('data');

    await Future.delayed(Duration.zero);

    emit(ShowTeacherClassLoading());

    await GetClasses.getData().then((value) {
      if (value['error'] != null && value['error'] == false) {
        print(value);

        var section = List<Classes>.from(
            value['data'].map((x) => Classes.fromJson(x)));

        emit(ShowTeacherClassLoaded(clasess: section));
      } else {
        emit(ShowTeacherClassError(error: value['error']));
      }
    });
  }
}
