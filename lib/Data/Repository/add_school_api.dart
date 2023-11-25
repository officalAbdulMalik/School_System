import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:school_system/Data/api_const.dart';
import 'package:school_system/Data/app_const.dart';

import 'package:school_system/Presentation/utils/shade_prefrence.dart';
import 'auth_apis.dart';

class AddSchoolApi {
  static Future<Map<String,dynamic>> addSchool(var data, var image) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer 597|QRgUei2peDhTSPgyKnNhgd5MgaaenSWNqPtqhpTP'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(AppApiUrls.addNewSchool));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    request.fields.addAll(data);


    http.StreamedResponse response = await request.send();

    print("here is sisisiis${response.reasonPhrase}");

    final respStr = await response.stream.bytesToString();

    return jsonDecode(respStr);
  }
}
