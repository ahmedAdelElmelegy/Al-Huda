part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

// for azkar
// get azkar by index state
final class AzkarGetByIndexLoading extends FavoriteState {}

final class AzkarGetByIndexSuccess extends FavoriteState {}

final class AzkarGetByIndexError extends FavoriteState {
  final String message;
  AzkarGetByIndexError(this.message);
}

// get azkar by index state
final class AzkarGetAllLoading extends FavoriteState {}

final class AzkarGetAllSuccess extends FavoriteState {}

final class AzkarGetAllError extends FavoriteState {}

// azkar update state
final class AzkarUpdateLoading extends FavoriteState {}

final class AzkarUpdateSuccess extends FavoriteState {}

final class AzkarUpdateError extends FavoriteState {}

// azkar
final class AzkarAddLoading extends FavoriteState {}

final class AzkarAddSuccess extends FavoriteState {}

final class AzkarAddError extends FavoriteState {}

// azkar delete state
final class AzkarDeleteLoading extends FavoriteState {}

final class AzkarDeleteSuccess extends FavoriteState {}

final class AzkarDeleteError extends FavoriteState {}

// azkar clear state
final class AzkarClearLoading extends FavoriteState {}

final class AzkarClearSuccess extends FavoriteState {}

final class AzkarClearError extends FavoriteState {}

// doaa

final class FavoriteAddDoaaLoading extends FavoriteState {}

final class FavoriteAddDoaaSuccess extends FavoriteState {}

final class FavoriteAddDoaaError extends FavoriteState {
  final String message;
  FavoriteAddDoaaError(this.message);
}

// get doaa by category
final class FavoriteGetDoaaByCategoryLoading extends FavoriteState {}

final class FavoriteGetDoaaByCategorySuccess extends FavoriteState {}

final class FavoriteGetDoaaByCategoryError extends FavoriteState {
  final String message;
  FavoriteGetDoaaByCategoryError(this.message);
}

// delete doaa
final class FavoriteDeleteDoaaLoading extends FavoriteState {}

final class FavoriteDeleteDoaaSuccess extends FavoriteState {}

final class FavoriteDeleteDoaaError extends FavoriteState {
  final String message;
  FavoriteDeleteDoaaError(this.message);
}
