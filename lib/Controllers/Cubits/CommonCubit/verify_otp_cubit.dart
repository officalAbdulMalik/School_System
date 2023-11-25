import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/forget_password_api.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitial());

  verifyOTp(String otp, String email) async {
    await Future.delayed(const Duration(microseconds: 19));

    emit(VerifyOtpLoading());
    log(otp);
    try {
      await ForgetPasswordApi.verifyOtp(otp, email).then((value) {
        if (value['status'] == 200 && value['error'] == null) {
          emit(VerifyOtpLoaded());
        } else {
          emit(VerifyOtpError(error: value['message']));
        }
      }).catchError((onError) {
        emit(VerifyOtpError(error: "Some Thing Wrong"));
        throw onError;
      });
    } catch (E) {
      emit(VerifyOtpError(error: E.toString()));
      rethrow;
    }
  }
}
