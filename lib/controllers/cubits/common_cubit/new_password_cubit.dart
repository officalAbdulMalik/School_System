import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/forget_password_api.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  NewPasswordCubit() : super(NewPasswordInitial());

  sendOtpTOEmail(String password, String newPassword, String email) async {
    emit(NewPasswordLoading());

    try {
      await ForgetPasswordApi.setPassword(password, newPassword, email)
          .then((value) {
        if (value['error'] == false) {
          emit(NewPasswordLoaded());
        } else {
          emit(NewPasswordError(error: value['message']));
        }
      }).catchError((onError) {
        emit(NewPasswordError(error: "Some Thing Wrong"));
        throw onError;
      });
    } catch (E) {
      emit(NewPasswordError(error: E.toString()));
      rethrow;
    }
  }
}
