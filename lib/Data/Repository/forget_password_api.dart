import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:school_system/Data/app_const.dart';

import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class ForgetPasswordApi {
  static Future<Map<String, dynamic>> sendEmail(String email) async {
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
        return data;

        print(request.body);
      } else {
        var data = jsonDecode(request.body);
        var msg = data['message'];
        Fluttertoast.showToast(msg: msg);
        return data;
      }
    } catch (E) {
      print(E.toString());

      return {
        "status": '300',
        "message": E.toString(),
      };
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(
      String otp, String email) async {
    var body = json.encode({'email': email, 'otp': otp});
    var headers = {
      'Content-Type': 'application/json',
    };
    http.Response request = await http.post(
        Uri.parse('$baseUrl/api/verify-otp'),
        body: body,
        headers: headers);

    print(request.statusCode);
    print(request.body);
    if (request.statusCode == 200) {
      var data = jsonDecode(request.body);
      return data;
    } else {
      var data = jsonDecode(request.body);
      return data;
    }
  }

  static Future<Map<String, dynamic>> setPassword(
      String password, String repPassowrd, String email) async {
    print(password);
    print(repPassowrd);

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = json.encode({
      'new_password': password,
      'new_confirm_password': repPassowrd,
      'email': email
    });

    http.Response request = await http.post(
        Uri.parse('$baseUrl/api/set-password'),
        body: body,
        headers: headers);

    print(request.statusCode);
    print(request.body);
    if (request.statusCode == 200) {
      var data = jsonDecode(request.body);
      return data;
      print(request.body);
    } else {
      var data = jsonDecode(request.body);

      return data;
    }
  }
}
