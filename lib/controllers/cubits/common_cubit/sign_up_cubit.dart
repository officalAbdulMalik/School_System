import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:meta/meta.dart';

import '../../../views/utils/shade_prefrence.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future createUser(
    String fullName,
    String lastName,
    String email,
    String password,
    title,
    language,
    abouUs,
    qulification,
    phoneNumber,
    gender,
    dob,
    BuildContext context,
  ) async {
    Map<String, String> bodyT = {
      "title": title,
      "first_name": fullName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "type": 'Teacher',
      "fcm_id": LoginApiShadePreference.preferences!.getString('device_token')!,
      "language": language,
      "hear_about_us": abouUs,
      "qualification": qulification,
      'gender': gender,
    };
    Map<String, String> bodyP = {
      "title": title,
      "first_name": fullName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "type": 'Parent',
      "fcm_id": LoginApiShadePreference.preferences!.getString('device_token')!,
      "language": language,
      "hear_about_us": abouUs,
      'mobile': phoneNumber,
      'occupation': qulification,
      'dob': dob,
      'gender': gender,
    };
    var type = LoginApiShadePreference.preferences!.getString('role');

    print(type);

    type == 'parents'
        ? makePostRequest(
            'https://www.dev.schoolsnow.parentteachermobile.com/api/auth/register',
            bodyP)
        : makePostRequest(
            'https://www.dev.schoolsnow.parentteachermobile.com/api/auth/register',
            bodyT);
  }

  Future<Map<String, dynamic>> makePostRequest(
      String url, Map<String, dynamic> data) async {
    emit(SignUpLoading());
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      emit(SignUpLoaded());
      Fluttertoast.showToast(msg: "User Created Successful");
      print(response.body);
      return json.decode(response.body);
    } else {
      var data = jsonDecode(response.body);
      print(data);
      String error = data['message'];
      emit(SignUpError());
      Fluttertoast.showToast(msg: error);
      throw Exception('Failed to make POST request: ${response.statusCode}');
    }
  }
}
