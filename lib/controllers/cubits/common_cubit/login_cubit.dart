import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/auth_apis.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginUser(String email, String password) async {
    await Future.delayed(Duration(microseconds: 10));

    emit(LoginLoading());

    try {
      await LoginApi.login(email, password).then((value) {
        if (value['status'] == 200 && value['error'] == null) {
          log(value.toString());
          emit(LoginLoaded());
        } else {
          emit(LoginError(error: value['message']));
        }
      }).catchError((e) {
        emit(LoginError(error: 'Some Thing Wrong'));
      });
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
