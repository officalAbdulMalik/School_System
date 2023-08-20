part of 'get_class_student_cubit.dart';

@immutable
abstract class GetClassStudentState {}

class GetClassStudentInitial extends GetClassStudentState {}

class GetClassStudentLoading extends GetClassStudentState {}

class GetClassStudentLoaded extends GetClassStudentState {
  ClassStudents model = ClassStudents();

  GetClassStudentLoaded({required this.model});
}

class GetClassStudentError extends GetClassStudentState {}
