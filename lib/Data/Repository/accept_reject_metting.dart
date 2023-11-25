import 'dart:convert';
import 'package:calendar_view/calendar_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:school_system/Data/api_const.dart';
import 'package:school_system/Data/app_const.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import 'auth_apis.dart';

class AcceptRejectMeeting {
  static Future<Map<String, dynamic>> acceptReject(
      int id, String status) async {
    var body = jsonEncode({'meeting_id': id, 'status': status});


    print(status);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    try {
      http.Response request = await http.post(
          Uri.parse(AppApiUrls.acceptRejectMeetings),
          body: body,
          headers: headers);

      print(request.statusCode);
      print(request.body);
      if (request.statusCode == 200) {
        var data1 = jsonDecode(request.body);
        return data1;
      } else {
        var data1 = jsonDecode(request.body);
        return data1;
      }
    } catch (e) {
      rethrow;
    }
  }
}
