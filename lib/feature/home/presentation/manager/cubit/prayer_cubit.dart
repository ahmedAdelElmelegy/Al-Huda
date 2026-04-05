import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
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

      // for (int i = 0; i < prayerTimes.length; i++) {
      // final scheduledTime = tz.TZDateTime.from(
      //   prayerTimes[i].value,
      //   tz.local,
      // );
      // bool isSwitchedOn = await PrayerServices.getSwitchState(
      //   i,
      //   Constants.keyPrefix,
      // );
      // bool isMute = await PrayerServices.getSwitchState(
      //   i,
      //   Constants.keyPrefixNotification,
      // );
      // debugPrint(isMute.toString());
      // if (isSwitchedOn) {
      //   NotificationService.scheduleNotification(
      //     i,
      //     'صلاة ${prayerTimes[i].key.tr()}',
      //     'حان وقت الصلاة ${prayerTimes[i].key.tr()}',
      //     scheduledTime,
      //     playSound: isMute,
      //     prayer: true,
      //     sound: 'athan',
      //     payload: 'prayer',
      //   );
      // }
      // }
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
        return prayer.key;
      }
    }

    // After last prayer (Isha), the next prayer is Fajr (of tomorrow)
    return "fagr";
  }

  DateTime getCurrentPrayerTime() {
    final now = DateTime.now();
    if (prayerTimes.isEmpty) return now;

    for (int i = 0; i < prayerTimes.length; i++) {
      final prayer = prayerTimes[i];
      if (now.isBefore(prayer.value)) {
        return prayer.value;
      }
    }

    // After last prayer (Isha), return tomorrow's Fajr time
    // We add 1 day to today's Fajr time stored in prayerTimes[0]
    return prayerTimes[0].value.add(const Duration(days: 1));
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
