part of 'qran_cubit.dart';

@immutable
sealed class QranState {}

final class QranInitial extends QranState {}

final class QranLoading extends QranState {}

final class QranSuccess extends QranState {
  final dynamic data;
  QranSuccess({required this.data});
}

final class QranError extends QranState {
  final String message;
  QranError({required this.message});
}
