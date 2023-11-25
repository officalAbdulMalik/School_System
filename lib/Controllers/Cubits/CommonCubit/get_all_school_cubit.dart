import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/app_const.dart';

import '../../../models/get_all_school_model.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import '../../../Data/Repository/auth_apis.dart';
import 'package:http/http.dart' as http;
part 'get_all_school_state.dart';

class GetAllSchoolCubit extends Cubit<GetAllSchoolState> {
  GetAllSchoolCubit() : super(GetAllSchoolInitial());

  Future getAllSchool(String endPoint) async {
    print('call');

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    await Future.delayed(const Duration(microseconds: 10));

    emit(GetAllSchoolLoading());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };
    var url = Uri.parse(
        '$baseUrl$endPoint');
    var response = await http.get(url, headers: headers);

    print('status code is ${response.statusCode}');
    print('settings body is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      var schools =
          List<Schools>.from(data['data'].map((x) => Schools.fromJson(x)));
      emit(GetAllSchoolLoaded(model: schools));
      // Get.snackbar('KASI', 'Settings get successfully');
    } else {
      var data = jsonDecode(response.body.toString());
      emit(GetAllSchoolError(error: data['message']));
    }
  }
}
