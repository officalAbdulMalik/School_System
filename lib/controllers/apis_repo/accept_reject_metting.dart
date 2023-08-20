import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import 'auth_apis.dart';

class AcceptRejectMetting {
  static Future<int> acceptReject(
      String id, String status, BuildContext context) async {
    var body = json.encode({'meeting_id': id, 'status': status});
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    http.Response request = await http.post(
        Uri.parse('$baseUrl/api/update/meeting'),
        body: body,
        headers: headers);
    var data = jsonDecode(request.body);
    print(request.statusCode);
    print(request.body);
    if (request.statusCode == 200) {
      var data1 = data['response'];
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Data Get Success')));
      return request.statusCode;
      print(request.body);
    } else {
      var msg = data['message'];
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg.toString())));
      return request.statusCode;
    }
  }
}
