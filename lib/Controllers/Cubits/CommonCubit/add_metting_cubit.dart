import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/add_mettings_api.dart';

part 'add_metting_state.dart';

class AddMettingCubit extends Cubit<AddMettingState> {
  AddMettingCubit() : super(AddMettingInitial());

  addMeetings(
      {required String title,
      required List<String> id,
      required String stdId,
      required String date,
      required String sTime,
      required String eTime,
      required String desc}) async {
    emit(AddMettingLoading());

    print(title);

    try {
      await AddMeetings.sendMeetingRequest(
              title, id, stdId, date, sTime, eTime, desc)
          .then((value) {
        if (value['status'] != null && value['status'] == 200) {
          emit(AddMettingLoaded());
        } else {
          emit(AddMettingError(error: value['message']));
        }
      }).catchError((e) {
        emit(AddMettingError(error: e.toString()));
      });
    } catch (e) {
      emit(AddMettingError(error: e.toString()));
    }
  }
}
