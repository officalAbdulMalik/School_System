import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/models/school_teacher_model.dart';

import 'package:school_system/Presentation/utils/shade_prefrence.dart';

part 'get_school_teacher_state.dart';

class GetSchoolTeacherCubit extends Cubit<GetSchoolTeacherState> {
  GetSchoolTeacherCubit() : super(GetSchoolTeacherInitial());

  Future getTeacher({required String apiUrl}) async {
    print('data');

    await Future.delayed(Duration.zero);

    emit(GetSchoolTeacherLoading());

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };

    var url = Uri.parse('$baseUrl/$apiUrl');
    var response = await http.get(
      url,
      headers: headers,
    );

    print('status code is ${response.statusCode}');
    print('settings body is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      SchoolTeachers teachers = SchoolTeachers.fromJson(data);

      emit(GetSchoolTeacherLoaded(teachers: teachers));
      // Get.snackbar('KASI', 'Settings get successfully');
    } else {
      emit(GetSchoolTeacherError());
      print('error');
      // var data = jsonDecode(response.body.toString());
      // print(data['message']);
    }
  }
}