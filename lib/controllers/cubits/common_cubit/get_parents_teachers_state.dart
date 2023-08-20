part of 'getl_parents_teachers_cubit.dart';

@immutable
abstract class GetAllParentsState {}

class GetAllParentsInitial extends GetAllParentsState {}

class GetAllParentsLoading extends GetAllParentsState {}

class GetAllParentsLoaded extends GetAllParentsState {
  ParentsTeacherModel model = ParentsTeacherModel();

  GetAllParentsLoaded({required this.model});
}

class GetAllParentsError extends GetAllParentsState {}
