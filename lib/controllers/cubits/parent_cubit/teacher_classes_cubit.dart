import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../models/show_teacher_classes.dart';
import '../../../views/utils/shade_prefrence.dart';

part 'teacher_classes_state.dart';

class TeacherClassesCubit extends Cubit<TeacherClassesState> {
  TeacherClassesCubit() : super(TeacherClassesInitial());

  Future getTeacherClasses(String teacherID) async {
    print('data');

    emit(TeacherClassesLoading());

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };

    var url = Uri.parse(
        'http://www.dev.schoolsnow.parentteachermobile.com/api/parent/classes/teacher/fetch?teacher_id=$teacherID');
    var response = await http.get(
      url,
      headers: headers,
    );

    print('status code is ${response.statusCode}');
    print('settings body is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      TeacherClasses classes = TeacherClasses.fromJson(data);

      emit(TeacherClassesLoaded(classes));
      // Get.snackbar('KASI', 'Settings get successfully');
    } else {
      emit(TeacherClassesError());
      print('error');
      // var data = jsonDecode(response.body.toString());
      // print(data['message']);
    }
  }
}
