import 'package:adhan/adhan.dart';
import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/utils/constants.dart';

import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class PrayerServices {
  Future<Coordinates> getCoordinates() async {
    String? latValue = await SharedPrefServices.getValue(Constants.lat);
    String? lngValue = await SharedPrefServices.getValue(Constants.lng);

    if (latValue != null && lngValue != null) {
      return Coordinates(double.parse(latValue), double.parse(lngValue));
    }

    return Coordinates(30.033333, 31.233334);
  }

  final params = CalculationMethod.egyptian.getParameters();
  Future<PrayerTimes> getPrayerTimes() async {
    final coordinates = await getCoordinates();
    return PrayerTimes.today(coordinates, params);
  }

  static String getFormattedGregorianDate(DateTime date, BuildContext context) {
    final locale = EasyLocalization.of(context)!.currentLocale;
    const daysAr = [
      "الأحد",
      "الاثنين",
      "الثلاثاء",
      "الأربعاء",
      "الخميس",
      "الجمعة",
      "السبت",
    ];
    const daysEn = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
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
    const monthsEn = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    String dayName = locale?.languageCode == 'ar'
        ? daysAr[date.weekday % 7]
        : daysEn[date.weekday % 7]; // weekday: 1=Mon..7=Sun
    String monthName = locale?.languageCode == 'ar'
        ? monthsAr[date.month - 1]
        : monthsEn[date.month - 1];

    return "${date.day} $dayName $monthName ${date.year}";
  }

  static String getFormattedHijriDate(DateTime date, BuildContext context) {
    final locale = EasyLocalization.of(context)!.currentLocale;
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
    const monthsEn = [
      "Muharram",
      "Safar",
      "Rabi' al-awwal",
      "Rabi' al-thani",
      "Jamadah al-awwal",
      "Jamadah al-thani",
      "Rajab",
      "Shawwal",
      "Dhul Qadah",
      "Dhul Hijjah",
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
    const daysEn = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
    ];

    String dayName = locale?.languageCode == 'ar'
        ? daysAr[date.weekday % 7]
        : daysEn[date.weekday % 7];

    String monthName = locale?.languageCode == 'ar'
        ? monthsHijri[hijriDate.hMonth - 1]
        : monthsEn[hijriDate.hMonth - 1];

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

    if (remainingTime.isNegative) {
      return "00:00:00";
    }

    final remainingHours = remainingTime.inHours;
    final remainingMinutes = remainingTime.inMinutes.remainder(60);
    final remainingSeconds = remainingTime.inSeconds.remainder(60);

    String twoDigits(int n) => n.toString().padLeft(2, "0");

    return "${twoDigits(remainingHours)}:"
        "${twoDigits(remainingMinutes)}:"
        "${twoDigits(remainingSeconds)}";
  }

  static Duration getDelayUnitMidnight() {
    tz.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    final midnight = tz.TZDateTime(tz.local, now.year, now.month, now.day + 1);
    return midnight.difference(now);
  }

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

  @pragma('vm:entry-point')
  static Future<void> workManagerTask() async {
    final prayerServices = PrayerServices();
    final times = await prayerServices.getPrayerTimes();
    await NotificationService.init();
    NotificationService.showInstantNotification(
      id: 501,
      title: 'اهلا بكم في تظبيق الهدي',
      body: 'تم تحديث مواعيد الصلاة',
    );
    debugPrint("✅ Workmanager PrayerTimes first time");
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
        prayer: true,
        sound: 'athan',
        payload: 'prayer',
      );
    }
  }

  static Future<void> runFirstTimeTask() async {
    final isFirstRun = await SharedPrefServices.getBool("firstRun") ?? true;

    if (isFirstRun) {
      await workManagerTask(); // تحديث فوري
      await SharedPrefServices.setBool(false, "firstRun"); // مايتكررش تاني
    }
  }
}
