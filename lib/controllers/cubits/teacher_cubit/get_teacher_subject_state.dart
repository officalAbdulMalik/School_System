part of 'get_teacher_subject_cubit.dart';

@immutable
abstract class GetTeacherSubjectState {}

class GetTeacherSubjectInitial extends GetTeacherSubjectState {}

class GetTeacherSubjectLoading extends GetTeacherSubjectState {}

class GetTeacherSubjectLoaded extends GetTeacherSubjectState {
  TeacherSubjects subjects;

  GetTeacherSubjectLoaded({required this.subjects});
}

class GetTeacherSubjectError extends GetTeacherSubjectState {}
