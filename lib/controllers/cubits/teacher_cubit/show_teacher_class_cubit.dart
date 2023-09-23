import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/get_teacher_class_model.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;
part 'show_teacher_class_state.dart';

class ShowTeacherClassCubit extends Cubit<ShowTeacherClassState> {
  ShowTeacherClassCubit() : super(ShowTeacherClassInitial());

  Future getClasses() async {
    print('data');

    emit(ShowTeacherClassLoading());

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };

    var url = Uri.parse(
        'http://www.dev.schoolsnow.parentteachermobile.com/api/teacher/classes/fetch');
    var response = await http.get(url, headers: headers);

    print('status code is ${response.statusCode}');
    print('settings body is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      TeacherShowClass sections = TeacherShowClass.fromJson(data);

      emit(ShowTeacherClassLoaded(model: sections));
      // Get.snackbar('KASI', 'Settings get successfully');
    } else {
      emit(ShowTeacherClassError());
      print('error');
      // var data = jsonDecode(response.body.toString());
      // print(data['message']);
    }
  }
}
