import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/get_all_mettings.dart';
import '../../../models/get_all_school_model.dart';
import '../../../views/utils/shade_prefrence.dart';
import '../../apis_repo/auth_apis.dart';
import 'package:http/http.dart' as http;
part 'get_all_meetings_state.dart';

class GetAllMeetingsCubit extends Cubit<GetAllMeetingsState> {
  GetAllMeetingsCubit() : super(GetAllMeetingsInitial());

  GetAllMettings schools = GetAllMettings();
  Future getAllMettings() async {
    print(LoginApiShadePreference.preferences!.getString("api_token"));

    emit(GetAllMeetingsLoading());
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url = Uri.parse(
          'https://www.dev.schoolsnow.parentteachermobile.com/api/get/meetings?status=new');
      var response = await http.get(url, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        schools = GetAllMettings.fromJson(data);
        emit(GetAllMeetingsLoaded(mettings: schools));
        // Get.snackbar('KASI', 'Settings get successfully');
      } else {
        emit(GetAllMeetingsError('No Data'));
        print('error');
        // var data = jsonDecode(response.body.toString());
        // print(data['message']);
      }
    } catch (e) {
      emit(GetAllMeetingsError(e.toString()));
      // Get.snackbar('KASI', 'Exception is $e');
    }
  }

  Future search(String search) async {
    emit(GetAllMeetingsLoading());
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer  ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var body = jsonEncode({
        'search_title': search,
      });

      var url = Uri.parse(
          'https://www.dev.schoolsnow.parentteachermobile.com/api/get/meetings?status=$search');
      var response = await http.post(url, headers: headers, body: body);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        schools = GetAllMettings.fromJson(data);
        emit(GetAllMeetingsLoaded(mettings: schools));
        // Get.snackbar('KASI', 'Settings get successfully');
      } else {
        emit(GetAllMeetingsError('No Data'));
        print('error');
        // var data = jsonDecode(response.body.toString());
        // print(data['message']);
      }
    } catch (e) {
      emit(GetAllMeetingsError(e.toString()));
      // Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
