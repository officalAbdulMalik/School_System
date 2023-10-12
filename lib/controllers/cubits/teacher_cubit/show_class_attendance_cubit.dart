import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_system/Data/Repository/show_attendance.dart';
import 'package:school_system/models/show_attendance_model.dart';

part 'show_class_attendance_state.dart';

class ShowClassAttendanceCubit extends Cubit<ShowClassAttendanceState> {
  ShowClassAttendanceCubit() : super(ShowClassAttendanceInitial());

  getAttendance(String id, String date) async {
    await Future.delayed(const Duration(microseconds: 20));

    emit(ShowClassAttendanceLoading());

    try {
      await ShowAttendance.showAttendance(id, date).then((value) {
        log(">>>>>>>>>>>>>>>>${value.toString()}");

        if (value['error'] != null && value['error'] == false) {
          var attendance = List<AttendanceModel>.from(value['data']
                  ['attendance']
              .map((x) => AttendanceModel.fromMap(x)));
          emit(ShowClassAttendanceLoaded(model: attendance));
        } else {
          emit(ShowClassAttendanceError(error: value['message']));
        }
      }).catchError((e) {
        // emit(GetSubjectsError(error: 'Some Thing Wrong'));
        throw e;
      });
    } catch (e) {
      // emit(GetSubjectsError(error: e.toString()));
      rethrow;
    }
  }
}
