import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  PrayerCubit(this.prayerServices) : super(PrayerInitial());
  final PrayerServices prayerServices;

  List<MapEntry<String, DateTime>> prayerTimes = [];
  DateTime? nextPrayerTime;
  String nextPrayer = "";

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
        final scheduledTime = tz.TZDateTime.from(
          prayerTimes[i].value,
          tz.local,
        );
        bool isSwitchedOn = await PrayerServices.getSwitchState(
          i,
          Constants.keyPrefix,
        );
        if (isSwitchedOn) {
          NotificationService.scheduleNotification(
            i,
            'حان الآن موعد ',
            'وقت الصلاة: ',
            scheduledTime,
            playSound: await PrayerServices.getSwitchState(
              i,
              Constants.keyPrefixNotification,
            ),
          );
        }
      }
    } catch (e) {
      emit(PrayerFailure());
    }
  }

  String getCurrentPrayer() {
    final now = DateTime.now();
    if (prayerTimes.isEmpty) return "fagr";

    for (int i = 0; i < prayerTimes.length; i++) {
      final prayer = prayerTimes[i];
      if (now.isBefore(prayer.value)) {
        final nextIndex = (i + 1) % prayerTimes.length;
        nextPrayer = prayerTimes[nextIndex].key;
        nextPrayerTime = prayerTimes[nextIndex].value;
        return prayer.key;
      }
    }

    // After last prayer
    nextPrayer = "fagr";
    nextPrayerTime = prayerTimes[0].value.add(const Duration(days: 1));
    return "isha";
  }

  DateTime getCurrentPrayerTime() {
    final now = DateTime.now();
    if (prayerTimes.isEmpty) return now;

    for (int i = 0; i < prayerTimes.length; i++) {
      final prayer = prayerTimes[i];
      if (now.isBefore(prayer.value)) {
        nextPrayerTime = prayerTimes[(i + 1) % prayerTimes.length].value;
        return prayer.value;
      }
    }

    // After last prayer
    nextPrayerTime = prayerTimes[0].value.add(const Duration(days: 1));
    return prayerTimes.last.value;
  }

  void scheduleSabah(DateTime time, String sound, int id) {
    final scheduledTime = tz.TZDateTime.from(time, tz.local);
    NotificationService.scheduleNotification(
      id,
      'azkar_sabah'.tr(),
      'azkar_sabah'.tr(),
      scheduledTime,
      sound: sound,
    );
  }
}
