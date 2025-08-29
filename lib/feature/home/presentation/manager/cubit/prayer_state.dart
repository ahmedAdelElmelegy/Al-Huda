part of 'prayer_cubit.dart';

@immutable
sealed class PrayerState {}

final class PrayerInitial extends PrayerState {}

final class PrayerLoading extends PrayerState {}

final class PrayerSucess extends PrayerState {}

final class PrayerFailure extends PrayerState {}

final class GetCurrentPrayerLoading extends PrayerState {}

final class GetCurrentPrayerSucess extends PrayerState {}
