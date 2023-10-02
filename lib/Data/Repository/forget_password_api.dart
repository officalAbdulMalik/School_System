import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class ForgetPasswordApi {
  static Future<int> sendEmail(String email) async {
    var body = json.encode({
      'email': email,
    });

    try {
      var headers = {'Content-Type': 'application/json'};
      http.Response request = await http.post(
          Uri.parse(
              'https://schoolsnow.parentteachermobile.com/api/forgot/password'),
          body: body,
          headers: headers);

      print(request.statusCode);
      print(request.body);
      if (request.statusCode == 200) {
        var data = jsonDecode(request.body);
        Fluttertoast.showToast(msg: 'Password Send Success');
        return request.statusCode;

        print(request.body);
      } else {
        var data = jsonDecode(request.body);
        var msg = data['message'];
        Fluttertoast.showToast(msg: msg);
        return request.statusCode;
      }
    } catch (E) {
      print(E.toString());

      return 300;
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(String otp) async {
    var body = json.encode({
      'pincode': otp,
    });
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    http.Response request = await http.post(
        Uri.parse(
            'https://schoolsnow.parentteachermobile.com/api/verify/pincode'),
        body: body,
        headers: headers);

    print(request.statusCode);
    print(request.body);
    if (request.statusCode == 200) {
      var data = jsonDecode(request.body);

      return data;
    } else {
      var data = jsonDecode(request.body);
      var msg = data['error'];
      Fluttertoast.showToast(msg: msg);
      return data;
    }
  }

  static Future<int> setPassword(String password, String repPassowrd) async {
    print(password);
    print(repPassowrd);

    var body = json
        .encode({'password': password, 'password_confirmation': repPassowrd});
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString('api_token')}'
    };
    http.Response request = await http.post(
        Uri.parse(
            'https://schoolsnow.parentteachermobile.com/api/reset/password'),
        body: body,
        headers: headers);

    print(request.statusCode);
    print(request.body);
    if (request.statusCode == 200) {
      var data = jsonDecode(request.body);
      Fluttertoast.showToast(msg: 'Password Change Success');
      return request.statusCode;
      print(request.body);
    } else {
      var data = jsonDecode(request.body);
      var msg = data['message'];
      Fluttertoast.showToast(msg: msg);
      return request.statusCode;
    }
  }
}
