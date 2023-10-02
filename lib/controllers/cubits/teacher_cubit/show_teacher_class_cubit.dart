import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_teacher_class.dart';
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Data/Repository/auth_apis.dart';

import '../../../models/get_teacher_class_model.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;
part 'show_teacher_class_state.dart';

class ShowTeacherClassCubit extends Cubit<ShowTeacherClassState> {
  ShowTeacherClassCubit() : super(ShowTeacherClassInitial());

  Future getClasses() async {
    print('data');

    emit(ShowTeacherClassLoading());

    await GetClasses.getData().then((value) {
      if (value['error'] != null && value['error'] == false) {
        print(value);

        TeacherShowClass sections = TeacherShowClass.fromJson(value);

        emit(ShowTeacherClassLoaded(model: sections));
      } else {
        emit(ShowTeacherClassError(error: value['message']));
      }
    });
  }
}
