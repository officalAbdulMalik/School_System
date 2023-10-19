import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/add_attendance.dart';

part 'add_attendance_state.dart';

class AddAttendanceCubit extends Cubit<AddAttendanceState> {
  AddAttendanceCubit() : super(AddAttendanceInitial());

  addAttendanceCubit({
    required String classId,
    required String date,
    required List<String> present,
    required List<String> absent,
  }) async {
    log(present.toString());
    log(absent.toString());
    await Future.delayed(const Duration(microseconds: 10));

    emit(AddAttendanceLoading());
    AddAttendance.addValue(
            classId: classId, present: present, date: date, absent: absent)
        .then((value) {
      if (value['error'] != null && value['error'] == true) {
        emit(AddAttendanceError(error: value['message']));
      } else {
        emit(AddAttendanceLoaded());
      }
    }).catchError((e) {
      emit(AddAttendanceError(error: e.toString()));
      log(e.toString());
      throw e;
    });
  }
}
