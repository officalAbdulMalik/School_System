part of 'new_password_cubit.dart';

@immutable
abstract class NewPasswordState {}

class NewPasswordInitial extends NewPasswordState {}

class NewPasswordLoading extends NewPasswordState {}

class NewPasswordLoaded extends NewPasswordState {}

class NewPasswordError extends NewPasswordState {
  String? error;

  NewPasswordError({this.error});
}
