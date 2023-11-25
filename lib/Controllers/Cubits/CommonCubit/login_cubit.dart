import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/auth_apis.dart';
import 'package:school_system/Presentation/utils/shade_prefrence.dart';

part 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginUser(String email, String password) async {
    await Future.delayed(Duration(microseconds: 10));

    emit(LoginLoading());

    try {
      await LoginApi.login(email, password).then((value) {
        if (value['status'] == 200 && value['error'] == null) {

          String token = value['token'];
          String role = value['user']['type'];
          String userId = value['user']['id'].toString();
          String profileImage = value['user']['image'] ?? "";

          LoginApiShadePreference.preferences!.setString('api_token', token);
          LoginApiShadePreference.preferences!.setString('type', role);
          LoginApiShadePreference.preferences!.setString('user_id', userId);
          LoginApiShadePreference.preferences!.setString('image', profileImage);

          log(value.toString());
          emit(LoginLoaded());
        } else {
          emit(LoginError(error: value['message']));
        }
      }).catchError((e) {
        emit(LoginError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(LoginError(error: e.toString()));
      rethrow;
    }
  }
}

