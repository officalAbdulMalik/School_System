part of 'create_chat_cubit.dart';

@immutable
abstract class CreateChatState {}

class CreateChatInitial extends CreateChatState {}

class CreateChatLoading extends CreateChatState {}

class CreateChatLoaded extends CreateChatState {}

class CreateChatError extends CreateChatState {
  final String? error;

  CreateChatError({this.error});
}
