import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'auth_apis.dart';

class UpdateProfile {
  static Future<int> updateProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String language,
    required String title,
    required String about,
    required String occupation,
    required String dob,
    required String gender,
    required String image,
  }) async {
    print(firstName);
    print(title);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://www.dev.schoolsnow.parentteachermobile.com/api/auth/update'));
    request.fields.addAll({
      'title': title,
      'first_name': firstName,
      'last_name': lastName,
      'language': language,
      'hear_about_us': about,
      'qualification': 'nothing',
      'occupation': occupation,
      'dob': dob,
      'gender': gender,
    });
    request.files.add(await http.MultipartFile.fromPath('image', image));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      return response.statusCode;
    } else {
      print(response.statusCode);
      var data = await response.stream.bytesToString();
      print(data);
      return response.statusCode;
    }
  }
}
