part of 'radio_cubit.dart';

@immutable
sealed class RadioState {}

final class RadioInitial extends RadioState {}

final class RadioLoading extends RadioState {}

final class RadioSuccess extends RadioState {
  final RadioModel data;
  RadioSuccess({required this.data});
}

final class RadioError extends RadioState {
  final ServerFailure failure;
  RadioError({required this.failure});
}
