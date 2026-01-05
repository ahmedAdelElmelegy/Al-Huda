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

  Future<PrayerTimes> getPrayerTimesForDate(DateTime date) async {
    final coordinates = await getCoordinates();
    final dateComponents = DateComponents(date.year, date.month, date.day);
    return PrayerTimes(coordinates, dateComponents, params);
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

  static Future<void> schedulePrayerNotifications() async {
    // Cancel existing notifications to avoid duplicates if re-running
    await NotificationService.cancelAllNotifications();

    final prayerService = PrayerServices();
    
    // Schedule for today, tomorrow, and day after
    for (int dayOffset = 0; dayOffset < 3; dayOffset++) {
       final date = DateTime.now().add(Duration(days: dayOffset));
       final prayerTimes = await prayerService.getPrayerTimesForDate(date);
       
        final labels = {
          "fagr": "الفجر",
          "shurooq": "الشروق",
          "dhuhr": "الظهر",
          "asr": "العصر",
          "maghrib": "المغرب",
          "isha": "العشاء",
        };

        final prayers = [
          MapEntry("fagr", prayerTimes.fajr),
          MapEntry("shurooq", prayerTimes.sunrise),
          MapEntry("dhuhr", prayerTimes.dhuhr),
          MapEntry("asr", prayerTimes.asr),
          MapEntry("maghrib", prayerTimes.maghrib),
          MapEntry("isha", prayerTimes.isha),
        ];

        for (int i = 0; i < prayers.length; i++) {
           final prayerName = prayers[i].key;
           final prayerTime = prayers[i].value;
           
           // ID Strategy: DayOfYear * 100 + PrayerIndex
           // Example: Day 365 -> 36500 + 0 (Fajr) = 36500.
           final id = (date.day + (date.month * 31) + (date.year * 372)) * 10 + i; 

           if (prayerTime.isAfter(DateTime.now())) {
             // Check sound preference
             bool playSound = await getSwitchState(i, Constants.keyPrefixNotification);
             
             await NotificationService.scheduleNotification(
                id,
                'صلاة ${labels[prayerName]}',
                'حان وقت الصلاة ${labels[prayerName]}',
                prayerTime,
                playSound: playSound,
                sound: 'athan',
                chanelId: playSound ? 'prayer_sound_channel' : 'prayer_mute_channel',
                chanelName: playSound ? 'Prayer Notifications (Sound)' : 'Prayer Notifications (Mute)',
                payload: 'prayer',
                prayer: true,
             );
             debugPrint("⏰ Scheduled Notification: $prayerName at $prayerTime (ID: $id)");
           }
        }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> workManagerTask() async {
    debugPrint("🔄 WorkManager: Starting Daily Sync...");
    try {
      await NotificationService.init();
      
      // Reschedule next 3 days of alarms
      await schedulePrayerNotifications();

      debugPrint("✅ WorkManager: Sync Complete. Alarms Refreshed.");
    } catch (e) {
      debugPrint("❌ WorkManager Error: $e");
    }
  }

  static Future<void> runFirstTimeTask() async {
    final isFirstRun = await SharedPrefServices.getBool("firstRun") ?? true;

    if (isFirstRun) {
      await workManagerTask(); // تحديث فوري
      await SharedPrefServices.setBool(false, "firstRun"); // مايتكررش تاني
    } else {
       // Ensure schedules are up to date on every app start, not just first run
       await schedulePrayerNotifications();
    }
  }
}
