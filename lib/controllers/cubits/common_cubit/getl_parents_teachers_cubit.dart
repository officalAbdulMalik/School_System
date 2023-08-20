import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../models/teacher_parents_data_model.dart';
import '../../../views/utils/shade_prefrence.dart';

part 'get_parents_teachers_state.dart';

class GetParentsTeachersCubit extends Cubit<GetAllParentsState> {
  GetParentsTeachersCubit() : super(GetAllParentsInitial());

  Future getParentsTeachers(String enPoint) async {
    /// theses api same call on multiple side like parents and teachers so from torp means the apis is call for teachers or parents

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    emit(GetAllParentsLoading());
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url = Uri.parse('https://schoolsnow.parentteachermobile.com$enPoint');
      var response = await http.get(url, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        ParentsTeacherModel model = ParentsTeacherModel.fromJson(data);
        emit(GetAllParentsLoaded(model: model));
        // Get.snackbar('KASI', 'Settings get successfully');
      } else {
        emit(GetAllParentsError());
        print('error');
        // var data = jsonDecode(response.body.toString());
        // print(data['message']);
      }
    } catch (e) {
      emit(GetAllParentsError());
      // Get.snackbar('KASI', 'Exception is $e');
    }
  }

  Future searchParentsTeachers(String type, String search) async {
    /// theses api same call on multiple side like parents and teachers so from torp means the apis is call for teachers or parents

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    emit(GetAllParentsLoading());
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var body = jsonEncode({'search_title': search, 'type': type});

      var url = Uri.parse(
          'https://schoolsnow.parentteachermobile.com/api/search/user');
      var response = await http.post(url, body: body, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        ParentsTeacherModel model = ParentsTeacherModel.fromJson(data);
        emit(GetAllParentsLoaded(model: model));
        // Get.snackbar('KASI', 'Settings get successfully');
      } else {
        emit(GetAllParentsError());
        print('error');
        // var data = jsonDecode(response.body.toString());
        // print(data['message']);
      }
    } catch (e) {
      emit(GetAllParentsError());
      // Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
