import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/get_all_school_model.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import '../../apis_repo/auth_apis.dart';
import 'package:http/http.dart' as http;
part 'get_all_school_state.dart';

class GetAllSchoolCubit extends Cubit<GetAllSchoolState> {
  GetAllSchoolCubit() : super(GetAllSchoolInitial());

  GetAllSchools schools = GetAllSchools();
  Future getAllSchool(String endPoint) async {
    print('call');

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    emit(GetAllSchoolLoading());
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };
    var url = Uri.parse(
        'https://www.dev.schoolsnow.parentteachermobile.com$endPoint');
    var response = await http.get(url, headers: headers);

    print('status code is ${response.statusCode}');
    print('settings body is ${response.body.toString()}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      schools = GetAllSchools.fromJson(data);
      emit(GetAllSchoolLoaded(model: schools));
      // Get.snackbar('KASI', 'Settings get successfully');
    }
  }
}
