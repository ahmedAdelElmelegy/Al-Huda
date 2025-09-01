part of 'azkar_cubit.dart';

@immutable
sealed class AzkarState {}

final class AzkarInitial extends AzkarState {}

final class AzkarLoading extends AzkarState {}

final class AzkarLoaded extends AzkarState {}

final class AzkarError extends AzkarState {}

// azkar add state
final class AzkarAddLoading extends AzkarState {}

final class AzkarAddSuccess extends AzkarState {}

final class AzkarAddError extends AzkarState {}

// get azkar by index state
final class AzkarGetByIndexLoading extends AzkarState {}

final class AzkarGetByIndexSuccess extends AzkarState {}

final class AzkarGetByIndexError extends AzkarState {}

// get azkar by index state
final class AzkarGetAllLoading extends AzkarState {}

final class AzkarGetAllSuccess extends AzkarState {}

final class AzkarGetAllError extends AzkarState {}

// azkar update state
final class AzkarUpdateLoading extends AzkarState {}

final class AzkarUpdateSuccess extends AzkarState {}

final class AzkarUpdateError extends AzkarState {}

// azkar delete state
final class AzkarDeleteLoading extends AzkarState {}

final class AzkarDeleteSuccess extends AzkarState {}

final class AzkarDeleteError extends AzkarState {}

// azkar clear state
final class AzkarClearLoading extends AzkarState {}

final class AzkarClearSuccess extends AzkarState {}

final class AzkarClearError extends AzkarState {}
