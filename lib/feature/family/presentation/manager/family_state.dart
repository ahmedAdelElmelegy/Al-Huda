part of 'family_cubit.dart';

@immutable
sealed class FamilyState {}

final class FamilyInitial extends FamilyState {}

final class FamilyLoading extends FamilyState {}

final class FamilySuccess extends FamilyState {
  final List<FamilyMember> members;
  FamilySuccess({required this.members});
}

final class FamilyFailure extends FamilyState {
  final String message;
  FamilyFailure({required this.message});
}
