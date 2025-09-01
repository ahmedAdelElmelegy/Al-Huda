part of 'doaa_cubit.dart';

@immutable
sealed class DoaaState {}

final class DoaaInitial extends DoaaState {}

final class DoaaLoading extends DoaaState {}

final class DoaaSuccess extends DoaaState {}

final class DoaaError extends DoaaState {
  final String message;
  DoaaError(this.message);
}
