part of 'ayat_cubit.dart';

@immutable
sealed class AyatState {}

final class AyatInitial extends AyatState {}

final class AyatLoading extends AyatState {}

final class AyatSuccess extends AyatState {
  final List<Ayah> ayatList;
  AyatSuccess({required this.ayatList});
}

final class AyatError extends AyatState {
  final ServerFailure failure;
  AyatError({required this.failure});
}

// audio setting
