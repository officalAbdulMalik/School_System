import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/forget_password_api.dart';

part 'send_email_otp_state.dart';

class SendEmailOtpCubit extends Cubit<SendEmailOtpState> {
  SendEmailOtpCubit() : super(SendEmailOtpInitial());

  sendOtpTOEmail(String email) async {
    emit(SendEmailOtpLoading());

    try {
      await ForgetPasswordApi.sendEmail(email).then((value) {
        if (value['status'] != 200) {

          print(value['error']);

          emit(SendEmailOtpError(error: value['message']));
        } else {
          emit(SendEmailOtpLoaded());
        }
      }).catchError((onError) {
        emit(SendEmailOtpError(error: "Some Thing Wrong"));
        throw onError;
      });
    } catch (E) {
      emit(SendEmailOtpError(error: E.toString()));
      rethrow;
    }
  }
}
