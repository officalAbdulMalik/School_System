part of 'assign_child_to_class_cubit.dart';

@immutable
abstract class AssignChildToClassState {}

class AssignChildToClassInitial extends AssignChildToClassState {}

class AssignChildToClassLoading extends AssignChildToClassState {}

class AssignChildToClassLoaded extends AssignChildToClassState {}

class AssignChildToClassError extends AssignChildToClassState {
  String? error;

  AssignChildToClassError({this.error});
}
