part of 'get_school_teacher_cubit.dart';

@immutable
abstract class GetSchoolTeacherState {}

class GetSchoolTeacherInitial extends GetSchoolTeacherState {}

class GetSchoolTeacherLoading extends GetSchoolTeacherState {}

class GetSchoolTeacherLoaded extends GetSchoolTeacherState {
  List<AllTeachers> teachers;

  GetSchoolTeacherLoaded({required this.teachers});
}

class GetSchoolTeacherError extends GetSchoolTeacherState {
  final String? error;

  GetSchoolTeacherError({this.error});
}
