part of 'show_class_attendance_cubit.dart';

@immutable
abstract class ShowClassAttendanceState {}

class ShowClassAttendanceInitial extends ShowClassAttendanceState {}

class ShowClassAttendanceLoading extends ShowClassAttendanceState {}

class ShowClassAttendanceLoaded extends ShowClassAttendanceState {}

class ShowClassAttendanceError extends ShowClassAttendanceState {}
