import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user_data_model.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;
part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit() : super(GetUserDataInitial());

  Future getParentsTeachers(String torP) async {
    /// theses api same call on multiple side like parents and teachers so from torp means the apis is call for teachers or parents

    print(LoginApiShadePreference.preferences!.getString("api_token"));

    emit(GetUserDataLoading());
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url = Uri.parse(
          'https://www.dev.schoolsnow.parentteachermobile.com/api/auth/details');
      var response = await http.get(url, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        UserData model = UserData.fromJson(data);
        emit(GetUserDataLoaded(model: model));
        // Get.snackbar('KASI', 'Settings get successfully');
      } else {
        print('error');
        // var data = jsonDecode(response.body.toString());
        // print(data['message']);
      }
    } catch (e) {
      // emit(GetAllParentsError());
      // Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
