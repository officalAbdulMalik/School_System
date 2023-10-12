import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:school_system/Data/app_const.dart';

import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'package:school_system/controllers/firebase_repos/firebase_notification.dart';

class LoginApi {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    String token = await FirebaseNotificationsService().getDeviceToken();

    var body = json.encode({
      'email': email,
      'password': password,
      'fcm_id': token,
    });
    var headers = {'Content-Type': 'application/json'};

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);

    try {
      var request = await http.post(
          Uri.parse(
              'https://www.dev.schoolsnow.parentteachermobile.com/api/auth/login'),
          body: body,
          headers: headers);

      print(request.statusCode);
      print(request.body);
      if (request.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Login Success');
        var data = jsonDecode(request.body);
        String token = data['token'];
        String role = data['user']['type'];
        String userId = data['user']['id'].toString();

        LoginApiShadePreference.preferences!.setString('api_token', token);
        LoginApiShadePreference.preferences!.setString('role', role);
        LoginApiShadePreference.preferences!.setString('user_id', userId);

        return jsonDecode(request.body);
      } else {
        // var data = jsonDecode(request.body);
        // var msg = data['message'];
        // print(msg);
        // Fluttertoast.showToast(msg: msg);
        return jsonDecode(request.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
