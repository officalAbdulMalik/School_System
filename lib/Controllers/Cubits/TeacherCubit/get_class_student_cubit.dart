import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:school_system/Data/Repository/show_class_student.dart';
import '../../../models/get_class_student_model.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

part 'get_class_student_state.dart';

class GetClassStudentCubit extends Cubit<GetClassStudentState> {
  GetClassStudentCubit() : super(GetClassStudentInitial());

  Future getStudent(String classId, String url) async {
    print('data');

    await Future.delayed(const Duration(microseconds: 10));

    emit(GetClassStudentLoading());

    try {
      await ShowClassStudent.getData(classId).then((value) {
        if (value['error'] != null && value['error'] == false) {
          var students = List<ClassStudents>.from(
              value['data'].map((x) => ClassStudents.fromMap(x)));
          emit(GetClassStudentLoaded(model: students));

          log(value.toString());
        } else {
          emit(GetClassStudentError(error: value['message']));
          print('error');
        }
      }).catchError((e) {
        emit(GetClassStudentError(error: e.toString()));
        throw e;
      });
    } catch (e) {
      emit(GetClassStudentError(error: e.toString()));
      rethrow;
    }

    // Get.snackbar('KASI', 'Settings get successfully');

    // var data = jsonDecode(response.body.toString());
    // print(data['message']);
  }
}
