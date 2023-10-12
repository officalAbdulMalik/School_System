import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/get_sessiosn.dart';
import 'package:school_system/models/get_sessions.dart';

part 'get_sessions_state.dart';

class GetSessionsCubit extends Cubit<GetSessionsState> {
  GetSessionsCubit() : super(GetSessionsInitial());

  getSessions() async {
    try {
      GetSessionsRepo.getData().then((value) {
        if (value['error'] != null && value['error'] == false) {
          var section = List<GetSessiosn>.from(
              value['data'].map((x) => GetSessiosn.fromMap(x)));

          emit(GetSessionsLoaded(data: section));
        } else {
          emit(GetSessionsError(error: value['message']));
        }
      }).catchError((e) {
        emit(GetSessionsError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      emit(GetSessionsError(error: e.toString()));
      rethrow;
    }
  }
}
