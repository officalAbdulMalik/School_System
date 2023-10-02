part of 'teacher_create_class_cubit.dart';

@immutable
abstract class TeacherCreateClassState {}

class TeacherCreateClassInitial extends TeacherCreateClassState {}

class TeacherCreateClassLoading extends TeacherCreateClassState {}

class TeacherCreateClassLoaded extends TeacherCreateClassState {}

class TeacherCreateClassError extends TeacherCreateClassState {
  String? error;

  TeacherCreateClassError({this.error});
}
