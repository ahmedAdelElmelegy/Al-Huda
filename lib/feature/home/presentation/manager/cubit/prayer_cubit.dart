import 'package:al_huda/core/services/prayer_services.dart';
import 'package:bloc/bloc.dart';
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
        nextPrayer = (i + 1 < prayerTimes.length)
            ? prayerTimes[i + 1].key
            : "dhuhr"; // بعد الفجر اللي عليه الدور الظهر
        nextPrayerTime = (i + 1 < prayerTimes.length)
            ? prayerTimes[i + 1].value
            : prayerTimes[2].value; // نخلي بعد الفجر الضهر

        return prayer.key;
      }
    }

    // لو معاد كل الصلوات خلص (بعد العشاء) → يبقى اللي عليه الدور الفجر بتاع بكرة
    nextPrayer = "dhuhr"; // بعد الفجر الضهر
    nextPrayerTime = prayerTimes[2].value.add(const Duration(days: 1));
    return "fagr"; // الحالي: الفجر (اليوم الجديد)
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

    // بعد العشاء → نخلي الحالي الفجر (اليوم الجديد)
    nextPrayerTime = prayerTimes[2].value.add(const Duration(days: 1));
    return prayerTimes[0].value.add(const Duration(days: 1)); // فجر بكرة
  }
}
