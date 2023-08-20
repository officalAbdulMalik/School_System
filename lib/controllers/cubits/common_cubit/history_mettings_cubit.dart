import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/models/history_mettings.dart';
import 'package:http/http.dart' as http;
import '../../../views/utils/shade_prefrence.dart';

part 'history_mettings_state.dart';

class HistoryMeetingsCubit extends Cubit<HistoryMettingsState> {
  HistoryMeetingsCubit() : super(HistoryMettingsInitial());

  Future getMeetingsHistory() async {
    print(LoginApiShadePreference.preferences!.getString("api_token"));

    emit(HistoryMettingsLoading());
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
      };

      var url = Uri.parse(
          'https://schoolsnow.parentteachermobile.com/api/get/status/meetings?status=accepted');
      var response = await http.get(url, headers: headers);

      print('status code is ${response.statusCode}');
      print('settings body is ${response.body.toString()}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        var model = HistroryModel.fromJson(data);
        emit(HistoryMettingsLoaded(model: model));
        // Get.snackbar('KASI', 'Settings get successfully');
      } else {
        emit(HistoryMettingsError());
        print('error');
        // var data = jsonDecode(response.body.toString());
        // print(data['message']);
      }
    } catch (e) {
      emit(HistoryMettingsError());
      // Get.snackbar('KASI', 'Exception is $e');
    }
  }
}
