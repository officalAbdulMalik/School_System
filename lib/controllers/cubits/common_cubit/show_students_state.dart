part of 'show_students_cubit.dart';

@immutable
abstract class ShowStudentsState {}

class ShowStudentsInitial extends ShowStudentsState {}

class ShowStudentsLoading extends ShowStudentsState {}

class ShowStudentsLoaded extends ShowStudentsState {}

class ShowStudentsError extends ShowStudentsState {}
