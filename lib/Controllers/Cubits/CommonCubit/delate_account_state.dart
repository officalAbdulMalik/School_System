part of 'delate_account_cubit.dart';

@immutable
abstract class DelateAccountState {}

class DelateAccountInitial extends DelateAccountState {}

class DelateAccountLoading extends DelateAccountState {}

class DelateAccountLoaded extends DelateAccountState {}

class DelateAccountError extends DelateAccountState {
  String? error;

  DelateAccountError({this.error});
}
