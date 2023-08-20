part of 'show_teacher_class_cubit.dart';

@immutable
abstract class ShowTeacherClassState {}

class ShowTeacherClassInitial extends ShowTeacherClassState {}

class ShowTeacherClassLoading extends ShowTeacherClassState {}

class ShowTeacherClassLoaded extends ShowTeacherClassState {
  TeacherShowClass model = TeacherShowClass();

  ShowTeacherClassLoaded({required this.model});
}

class ShowTeacherClassError extends ShowTeacherClassState {}
