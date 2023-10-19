import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../models/teacher_subjects.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

part 'get_teacher_subject_state.dart';

class GetTeacherSubjectCubit extends Cubit<GetTeacherSubjectState> {
  GetTeacherSubjectCubit() : super(GetTeacherSubjectInitial());

  Future getSubject(String id) async {
    print('data');

    await Future.delayed(Duration.zero);

    emit(GetTeacherSubjectLoading());

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };

    var url = Uri.parse(
        'http://www.dev.schoolsnow.parentteachermobile.com/api/teacher/class/subjects?class_id=$id');
    var response = await http.get(url, headers: headers);

    print('status code is ${response.statusCode}');
    print('settings body is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      TeacherSubjects subjects = TeacherSubjects.fromJson(data);

      emit(GetTeacherSubjectLoaded(subjects: subjects));
      // Get.snackbar('KASI', 'Settings get successfully');
    } else {
      var data = jsonDecode(response.body.toString());
      emit(GetTeacherSubjectError(error: data['error']));
      print('error');
      // var data = jsonDecode(response.body.toString());
      // print(data['message']);
    }
  }
}
