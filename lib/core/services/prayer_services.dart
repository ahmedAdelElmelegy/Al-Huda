import 'package:adhan/adhan.dart';
import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/utils/constants.dart';

import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class PrayerServices {
  Future<Coordinates> getCoordinates() async {
    String? latValue = await SharedPrefServices.getValue(Constants.lat);
    String? lngValue = await SharedPrefServices.getValue(Constants.lng);

    if (latValue != null && lngValue != null) {
      return Coordinates(double.parse(latValue), double.parse(lngValue));
    }

    return Coordinates(30.0444, 31.2357);
  }

  final params = CalculationMethod.egyptian.getParameters();
  Future<PrayerTimes> getPrayerTimes() async {
    final coordinates = await getCoordinates();
    return PrayerTimes.today(coordinates, params);
  }

  static String getFormattedGregorianDate(DateTime date) {
    const daysAr = [
      "الأحد",
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة",
      "السبت",
    ];

    const monthsAr = [
      "يناير",
      "فبراير",
      "مارس",
      "إبريل",
      "مايو",
      "يونيو",
      "يوليو",
      "أغسطس",
      "سبتمبر",
      "أكتوبر",
      "نوفمبر",
      "ديسمبر",
    ];

    String dayName = daysAr[date.weekday % 7]; // weekday: 1=Mon..7=Sun
    String monthName = monthsAr[date.month - 1];

    return "${date.day} $dayName $monthName ${date.year}";
  }

  static String getFormattedHijriDate(DateTime date) {
    final hijriDate = HijriCalendar.fromDate(date);

    const monthsHijri = [
      "محرم",
      "صفر",
      "ربيع الأول",
      "ربيع الثاني",
      "جمادى الأولى",
      "جمادى الآخرة",
      "رجب",
      "شعبان",
      "رمضان",
      "شوال",
      "ذو القعدة",
      "ذو الحجة",
    ];

    const daysAr = [
      "الأحد",
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة",
      "السبت",
    ];

    String dayName = daysAr[date.weekday % 7];

    String monthName = monthsHijri[hijriDate.hMonth - 1];

    return "$dayName $monthName ${hijriDate.hYear}";
  }

  static String getNextAmPm(DateTime time) {
    return time.hour < 12 ? 'Am'.tr() : 'Pm'.tr();
  }

  static String getCurrentAmPm(DateTime time) {
    return time.hour < 12 ? 'am'.tr() : 'pm'.tr();
  }

  static String getRemainingTime(PrayerCubit cubit) {
    final now = DateTime.now();
    final currentPrayerTime = cubit.getCurrentPrayerTime();

    final remainingTime = currentPrayerTime.difference(now);
    final remainingHours = remainingTime.inHours;
    final remainingMinutes = remainingTime.inMinutes.remainder(60);
    final remainingSeconds = remainingTime.inSeconds.remainder(60);
    return '$remainingSeconds : $remainingMinutes : $remainingHours';
  }

  static Duration getDelayUnitMidnight() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1, 0, 5);
    return tomorrow.difference(now);
  }

  // for notificaton  setting

  static Future<void> saveSwitchState(
    int index,
    bool value,
    String keyPrefix,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("$keyPrefix$index", value);
  }

  static Future<bool> getSwitchState(int index, String keyPrefix) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("$keyPrefix$index") ?? true; // default = true
  }

  static DateTime calculateDataTime(int hour, int minute) {
    final now = DateTime.now();
    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    ); // 6:00 AM

    if (scheduledDate.isBefore(now)) {
      // لو الوقت عدى، نزود يوم
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  // convert from string to time of day
  static Future<TimeOfDay?> convertStringToTimeOfDay(String time) async {
    String? savedTime = await SharedPrefServices.getValue(time);
    if (savedTime != null && savedTime.isNotEmpty) {
      final parts = savedTime.split(":");
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }
    return null;
  }

  static Future<void> workManagerTask() async {
    final prayerServices = PrayerServices();
    final times = await prayerServices.getPrayerTimes();
    await NotificationService.init();

    final labels = {
      "fagr": "الفجر",
      "shurooq": "الشروق",
      "dhuhr": "الظهر",
      "asr": "العصر",
      "maghrib": "المغرب",
      "isha": "العشاء",
    };

    final prayerTimes = [
      MapEntry("fagr", times.fajr),
      MapEntry("shurooq", times.sunrise),
      MapEntry("dhuhr", times.dhuhr),
      MapEntry("asr", times.asr),
      MapEntry("maghrib", times.maghrib),
      MapEntry("isha", times.isha),
    ];

    for (int i = 0; i < prayerTimes.length; i++) {
      final prayer = prayerTimes[i];
      final scheduledTime = tz.TZDateTime.from(prayer.value, tz.local);
      NotificationService.scheduleNotification(
        i,
        'صلاة ${labels[prayer.key]}',
        'حان وقت الصلاة ${labels[prayer.key]}',
        scheduledTime,
        playSound: await PrayerServices.getSwitchState(
          i,
          Constants.keyPrefixNotification,
        ),
        sound: 'athan',
      );
    }
  }
}
