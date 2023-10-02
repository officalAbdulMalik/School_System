import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/accept_reject_metting.dart';

part 'accept_reject_mettings_state.dart';

class AcceptRejectMeetingsCubit extends Cubit<AcceptRejectMeetingsState> {
  AcceptRejectMeetingsCubit() : super(AcceptRejectMeetingsInitial());

  Future acceptRejectMeetings(String id, String status) async {
    Future.delayed(const Duration(milliseconds: 20));

    emit(AcceptRejectMeetingsLoading());
    await AcceptRejectMetting.acceptReject(id, status).then((value) {
      if (value['status'] != null && value['status'] == 200) {
        emit(AcceptRejectMeetingsLoaded());
      } else {
        emit(AcceptRejectMeetingsError(error: value['error']));
      }
    }).catchError((e) {
      emit(AcceptRejectMeetingsError(error: e.toString()));
    });
  }
}
