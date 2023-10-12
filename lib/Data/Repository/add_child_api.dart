import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

import 'package:mime/mime.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

class AddChildRepo {
  static Future addChild({
    required String firstName,
    required String lastName,
    required String relation,
    required String dob,
    required String gender,
    required String image,
  }) async {
    print(firstName);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://www.dev.schoolsnow.parentteachermobile.com/api/parent/student/create'));
    request.fields.addAll({
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'gender': gender,
      'relationship': relation
    });
    var mimeTypeData = lookupMimeType(image);
    var file = await http.MultipartFile.fromPath('image', image,
        contentType: MediaType.parse(mimeTypeData!));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print(response.statusCode);
    print(response.reasonPhrase);

    if (response.statusCode == 200) {
      print(response);
      return 200;
    } else {
      var data = await response.stream.bytesToString();
      print(data);
      return 300;
    }
  }
}
