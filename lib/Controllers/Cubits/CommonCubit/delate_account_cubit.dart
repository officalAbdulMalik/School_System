import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/delete_account.dart';

part 'delate_account_state.dart';

class DelateAccountCubit extends Cubit<DelateAccountState> {
  DelateAccountCubit() : super(DelateAccountInitial());

  deleteAccount() async {
    await Future.delayed(const Duration(microseconds: 10));
    emit(DelateAccountLoading());
    try {
      await DeleteAccount.deleteAccount('').then((value) {
        if (value['error'] == false) {
          emit(DelateAccountLoaded());
        } else {
          emit(DelateAccountError(error: value['error']));
        }
      }).catchError((e) {
        emit(DelateAccountError(error: 'Some thing wrong'));
      });
    } catch (e) {
      emit(DelateAccountError(error: e.toString()));
    }
  }
}
