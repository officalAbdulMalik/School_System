part of 'history_mettings_cubit.dart';

@immutable
abstract class HistoryMettingsState {}

class HistoryMettingsInitial extends HistoryMettingsState {}

class HistoryMettingsLoading extends HistoryMettingsState {}

class HistoryMettingsLoaded extends HistoryMettingsState {
  HistroryModel model = HistroryModel();

  HistoryMettingsLoaded({required this.model});
}

class HistoryMettingsError extends HistoryMettingsState {}
