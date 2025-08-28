import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit(this.prayerServices) : super(PrayerInitial());
  final PrayerServices prayerServices;

  List<MapEntry<String, DateTime>> prayerTimes = [];
  void getPrayerTimes() {
    emit(PrayerLoading());
    try {
      final times = prayerServices.getPrayerTimes();
      prayerTimes = [
        MapEntry("fagr", times.fajr),
        MapEntry("shurooq", times.sunrise),
        MapEntry("dhuhr", times.dhuhr),
        MapEntry("asr", times.asr),
        MapEntry("maghrib", times.maghrib),
        MapEntry("isha", times.isha),
      ];
      emit(PrayerSucess());
      for (int i = 0; i < prayerTimes.length; i++) {
        NotificationService.scheduleNotification(
          i,
          'حان الآن موعد ${prayerTimes[i].key.tr()}',
          'وقت الصلاة: ${prayerTimes[i].key.tr()}',
          prayerTimes[i].value,
        );
      }
    } catch (e) {
      emit(PrayerFailure());
    }
  }

  String nextPrayer = "";

  String getCurrentPrayer() {
    final now = DateTime.now();

    for (int i = 0; i < prayerTimes.length; i++) {
      final prayer = prayerTimes[i];

      if (now.isBefore(prayer.value)) {
        // أول صلاة جاية
        if (now.isBefore(prayer.value)) {
          nextPrayer = prayer.key;
          nextPrayerTime = prayer.value;
          return prayer.key;
        }

        return prayer.key;
      }
    }

    nextPrayer = "fagr";
    nextPrayerTime = prayerTimes[0].value.add(const Duration(days: 1));
    return "fagr";
  }

  DateTime? nextPrayerTime;
  DateTime getCurrentPrayerTime() {
    final now = DateTime.now();

    for (int i = 0; i < prayerTimes.length; i++) {
      final prayer = prayerTimes[i];

      if (now.isBefore(prayer.value)) {
        nextPrayerTime = (i + 1 < prayerTimes.length)
            ? prayerTimes[i + 1].value
            : prayerTimes[2].value; // بعد الفجر → الضهر
        return prayer.value;
      }
    }

    nextPrayerTime = prayerTimes[0].value.add(const Duration(days: 1));
    return prayerTimes[0].value.add(const Duration(days: 1)); // فجر بكرة
  }
}
