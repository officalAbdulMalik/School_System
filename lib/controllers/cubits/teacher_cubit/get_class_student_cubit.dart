import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../models/get_class_student_model.dart';
import '../../../views/utils/shade_prefrence.dart';

part 'get_class_student_state.dart';

class GetClassStudentCubit extends Cubit<GetClassStudentState> {
  GetClassStudentCubit() : super(GetClassStudentInitial());

  Future getSections(String classId) async {
    print('data');

    emit(GetClassStudentLoading());

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };

    var body = json.encode({"class_id": classId});

    var url = Uri.parse(
        'http://www.dev.schoolsnow.parentteachermobile.com/api/students?first_name=&last_name=');
    var response = await http.get(
      url,
      headers: headers,
    );

    print('status code is ${response.statusCode}');
    print('settings body is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      ClassStudents students = ClassStudents.fromJson(data);

      emit(GetClassStudentLoaded(model: students));
      // Get.snackbar('KASI', 'Settings get successfully');
    } else {
      emit(GetClassStudentError());
      print('error');
      // var data = jsonDecode(response.body.toString());
      // print(data['message']);
    }
  }
}
