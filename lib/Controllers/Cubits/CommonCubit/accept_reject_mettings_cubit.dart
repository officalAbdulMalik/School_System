import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/accept_reject_metting.dart';

part 'accept_reject_mettings_state.dart';

class AcceptRejectMeetingsCubit extends Cubit<AcceptRejectMeetingsState> {
  AcceptRejectMeetingsCubit() : super(AcceptRejectMeetingsInitial());

  acceptRejectMeetings(int id, String status) async {
    await Future.delayed(const Duration(milliseconds: 20));

    emit(AcceptRejectMeetingsLoading());

    log('here is $id');

    await AcceptRejectMeeting.acceptReject(id, status).then((value) {
      if (value['status'] != null && value['status'] == 200) {
        log("here is meeting${value.toString()}");

        emit(AcceptRejectMeetingsLoaded());
      } else {
        emit(AcceptRejectMeetingsError(error: value['error']));
      }
    }).catchError((e) {
      emit(AcceptRejectMeetingsError(error: e.toString()));
      throw e;
    });
  }
}
