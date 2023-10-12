part of 'show_class_attendance_cubit.dart';

@immutable
abstract class ShowClassAttendanceState {}

class ShowClassAttendanceInitial extends ShowClassAttendanceState {}

class ShowClassAttendanceLoading extends ShowClassAttendanceState {}

class ShowClassAttendanceLoaded extends ShowClassAttendanceState {
  List<AttendanceModel>? model;

  ShowClassAttendanceLoaded({this.model});
}

class ShowClassAttendanceError extends ShowClassAttendanceState {
  String? error;

  ShowClassAttendanceError({this.error});
}
