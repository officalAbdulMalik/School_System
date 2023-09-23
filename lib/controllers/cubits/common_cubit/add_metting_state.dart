part of 'add_metting_cubit.dart';

@immutable
abstract class AddMettingState {}

class AddMettingInitial extends AddMettingState {}

class AddMettingLoading extends AddMettingState {}

class AddMettingLoaded extends AddMettingState {}

class AddMettingError extends AddMettingState {
  String? error;

  AddMettingError({this.error});
}
