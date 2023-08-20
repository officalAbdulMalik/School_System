part of 'get_section_cubit.dart';

@immutable
abstract class GetSectionState {}

class GetSectionInitial extends GetSectionState {}

class GetSectionLoading extends GetSectionState {}

class GetSectionLoaded extends GetSectionState {
  Sections model = Sections();

  GetSectionLoaded({required this.model});
}

class GetSectionError extends GetSectionState {}
