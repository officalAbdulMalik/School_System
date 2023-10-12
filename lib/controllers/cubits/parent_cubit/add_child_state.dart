part of 'add_child_cubit.dart';

@immutable
abstract class AddChildState {}

class AddChildInitial extends AddChildState {}

class AddChildLoading extends AddChildState {}

class AddChildLoaded extends AddChildState {}

class AddChildError extends AddChildState {
  String? error;

  AddChildError({this.error});
}
