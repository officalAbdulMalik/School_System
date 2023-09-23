import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

import 'auth_apis.dart';

class AcceptRejectMetting {
  static Future<Map<String, dynamic>> acceptReject(
      String id, String status) async {
    var body = json.encode({'meeting_id': id, 'status': status});
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    try {
      http.Response request = await http.post(
          Uri.parse('$baseUrl/api/update/meeting'),
          body: body,
          headers: headers);
      var data = jsonDecode(request.body);
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
