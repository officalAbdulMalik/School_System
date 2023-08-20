import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:school_system/views/bottom_bar_techer/metting_screen.dart';

import '../../views/utils/shade_prefrence.dart';
import 'auth_apis.dart';

class AddSchoolApi {
  static Future<int> addSchool({
    required BuildContext context,
    String? id,
    String? scName,
    String? address,
    String? local,
    String? zip,
    String? postCode,
    String? email,
    String? web,
    String? phNo,
    File? image,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${LoginApiShadePreference.preferences!.getString("api_token")}'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/api/add/school'));
    request.fields.addAll({
      'country_id': id == "United Kingdom" ? "230" : "231",
      'school_name': scName!,
      'address': address!,
      'locality': local!,
      'post_town': postCode!,
      'post_code': zip!,
      'email': email!,
      'phone': phNo!,
      'website': web!,
    });
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());

      return response.statusCode;
    } else {
      var data = response.stream.bytesToString();
      print(data);
      print(response.reasonPhrase);
      return response.statusCode;
    }
  }
}
