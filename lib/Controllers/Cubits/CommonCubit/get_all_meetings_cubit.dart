import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_mettings.dart';
import 'package:school_system/Data/app_const.dart';
import '../../../models/get_all_mettings.dart';
import '../../../models/get_all_school_model.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:http/http.dart' as http;
part 'get_all_meetings_state.dart';

class GetAllMeetingsCubit extends Cubit<GetAllMeetingsState> {
  GetAllMeetingsCubit() : super(GetAllMeetingsInitial());

  Future getAllMettings() async {
    await Future.delayed(Duration(microseconds: 10));

    emit(GetAllMeetingsLoading());
    try {
      GetMeetings().getAllMeetings().then((value) {
        print("here is the meetings${value['data']}");
        if (value['status'] != null && value['status'] == 200) {
          var data = value['data'];
          var meeting = List<GetAllMeetings>.from(
              data.map((x) => GetAllMeetings.fromMap(x)));
          emit(GetAllMeetingsLoaded(meetings: meeting));
        } else {
          print('error state');
          emit(GetAllMeetingsError(error: value['error']));
        }
      }).catchError((e) {
        emit(GetAllMeetingsError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(GetAllMeetingsError(error: e.toString()));
      rethrow;
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

      var url = Uri.parse('$baseUrl/api/get/meetings?status=$search');
      var response = await http.post(url, headers: headers, body: body);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        var meetings = List<GetAllMeetings>.from(
            data.map((x) => GetAllMeetings.fromJson(x)));
        emit(GetAllMeetingsLoaded(meetings: meetings));
      } else {
        emit(GetAllMeetingsError(error: 'No Data'));
        print('error');
        // var data = jsonDecode(response.body.toString());
        // print(data['message']);
      }
    } catch (e) {
      emit(GetAllMeetingsError(error: e.toString()));
      // Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
