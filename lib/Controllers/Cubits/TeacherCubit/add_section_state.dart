part of 'add_section_cubit.dart';

@immutable
abstract class AddSectionState {}

class AddSectionInitial extends AddSectionState {}

class AddSectionLoading extends AddSectionState {}

class AddSectionLoaded extends AddSectionState {}

class AddSectionError extends AddSectionState {
  String? error;

  AddSectionError({this.error});
}
