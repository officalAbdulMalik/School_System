part of 'get_section_cubit.dart';

@immutable
abstract class GetSectionState {}

class GetSectionInitial extends GetSectionState {}

class GetSectionLoading extends GetSectionState {}

class GetSectionLoaded extends GetSectionState {
  List<Sections> sections;

  GetSectionLoaded({required this.sections});
}

class GetSectionError extends GetSectionState {
  String? error;

  GetSectionError({this.error});
}
