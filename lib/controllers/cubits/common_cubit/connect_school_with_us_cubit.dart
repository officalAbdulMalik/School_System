import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/school_in_info.dart';

part 'connect_school_with_us_state.dart';

class ConnectSchoolWithUsCubit extends Cubit<ConnectSchoolWithUsState> {
  ConnectSchoolWithUsCubit() : super(ConnectSchoolWithUsInitial());

  assignSchool(int id) async {
    await Future.delayed(const Duration(microseconds: 10));

    emit(ConnectSchoolLoading());

    try {
      await AddSchoolInOverInfo.addSchool(id).then((value) {
        if (value['status'] != null && value['status'] == 200) {
          emit(ConnectSchoolWithUsLoaded());
        } else {
          emit(ConnectSchoolWithUsError(error: value['message']));
        }
      }).catchError((e) {
        emit(ConnectSchoolWithUsError(error: 'Some Thing Wrong'));
      });
    } catch (e) {
      emit(ConnectSchoolWithUsError(error: e.toString()));
    }
  }
}
