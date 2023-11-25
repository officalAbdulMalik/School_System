part of 'show_teacher_class_cubit.dart';

@immutable
abstract class ShowTeacherClassState {}

class ShowTeacherClassInitial extends ShowTeacherClassState {}

class ShowTeacherClassLoading extends ShowTeacherClassState {}

class ShowTeacherClassLoaded extends ShowTeacherClassState {
 final List<Classes> clasess;

  ShowTeacherClassLoaded({required this.clasess});
}

class ShowTeacherClassError extends ShowTeacherClassState {
  String? error;

  ShowTeacherClassError({this.error});
}
