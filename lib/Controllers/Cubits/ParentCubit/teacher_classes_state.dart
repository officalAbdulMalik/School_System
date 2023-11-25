part of 'teacher_classes_cubit.dart';

@immutable
abstract class TeacherClassesState {}

class TeacherClassesInitial extends TeacherClassesState {}

class TeacherClassesLoading extends TeacherClassesState {}

class TeacherClassesLoaded extends TeacherClassesState {
final  List<Classes>? classes;

  TeacherClassesLoaded({this.classes});
}

class TeacherClassesError extends TeacherClassesState {
 final String? error;

  TeacherClassesError({this.error});
}
