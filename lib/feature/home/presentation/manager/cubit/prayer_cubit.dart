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
  Future<void> getPrayerTimes() async {
    emit(PrayerLoading());
    try {
      final times = await prayerServices.getPrayerTimes();
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
      final nextPrayerIndex = i + 1;
      if (now.isBefore(prayer.value)) {
        if (now.isBefore(prayer.value)) {
          if (prayerTimes.length > nextPrayerIndex) {
            nextPrayer = prayerTimes[nextPrayerIndex].key;
            nextPrayerTime = prayerTimes[nextPrayerIndex].value;
          } else {
            nextPrayer = prayerTimes[0].key;
            nextPrayerTime = prayerTimes[0].value.add(const Duration(days: 1));
          }
          return prayer.key;
        }

        return prayer.key;
      }
    }
    if (prayerTimes.isEmpty) {
      debugPrint("⚠️ مفيش أوقات صلاه متسجله دلوقتي");
      return "fagr";
    }
    nextPrayer = "fagr";
    nextPrayerTime = prayerTimes[0].value.add(const Duration(days: 1));
    return "fagr";
  }

  DateTime? nextPrayerTime;

  DateTime getCurrentPrayerTime() {
    emit(GetCurrentPrayerLoading());
    final now = DateTime.now();

    if (prayerTimes.isEmpty) return now;

    for (int i = 0; i < prayerTimes.length; i++) {
      final prayer = prayerTimes[i];

      if (now.isBefore(prayer.value)) {
        // الصلاة الحالية = الصلاة السابقة
        final currentPrayer = prayer.value;

        nextPrayerTime = prayerTimes[i + 1].value;

        emit(GetCurrentPrayerSucess());
        return currentPrayer;
      }
    }

    // لو الوقت بعد آخر صلاة (العشاء)
    final currentPrayer = prayerTimes.last.value; // Isha اليوم
    nextPrayerTime = prayerTimes.first.value.add(
      const Duration(days: 1),
    ); // Fajr الغد

    emit(GetCurrentPrayerSucess());
    return currentPrayer;
  }

  //   notification for sabah and massaa

  void scheduleSabah(DateTime time, String sound, int id) {
    NotificationService.scheduleNotification(
      id,
      'azkar_sabah'.tr(),
      'azkar_sabah'.tr(),
      time,
      sound: sound,
    );
  }
}
