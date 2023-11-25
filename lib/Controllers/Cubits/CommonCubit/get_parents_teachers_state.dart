part of 'get_parents_teachers_cubit.dart';

abstract class GetAllParentsState {}

class GetAllParentsInitial extends GetAllParentsState {}

class GetAllParentsLoading extends GetAllParentsState {}

class GetAllParentsLoaded extends GetAllParentsState {
  List<Participation>? model;

  List<bool> checkList;

  GetAllParentsLoaded({ required this.checkList,this.model});
}

class GetAllParentsError extends GetAllParentsState {
  String? error;

  GetAllParentsError({this.error});
}

class GetAllParentsFirstState extends GetAllParentsState {}
