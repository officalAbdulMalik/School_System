import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:intl/intl.dart';
import 'package:school_system/views/loginScreen.dart';
import 'package:school_system/views/utils/colors.dart';
import 'package:school_system/views/utils/shade_prefrence.dart';

import '../../views/verify_email_screen.dart';

String baseUrl = 'https://schoolsnow.parentteachermobile.com';

class LoginApi {
  static Future<int> createUser(
      String email, String password, BuildContext context) async {
    var body = json.encode({
      'email': email,
      'password': password,
    });
    var headers = {'Content-Type': 'application/json'};

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);

    var request = await http.post(
        Uri.parse('https://schoolsnow.parentteachermobile.com/api/auth/login'),
        body: body,
        headers: headers);

    print(request.statusCode);
    print(request.body);
    if (request.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Login Success');
      var data = jsonDecode(request.body);
      String token = data['token'];
      LoginApiShadePreference.preferences!.setString('api_token', token);
      return request.statusCode;
    } else {
      var data = jsonDecode(request.body);
      var msg = data['message'];
      print(msg);
      Fluttertoast.showToast(msg: msg);
      return request.statusCode;
    }
  }
}
