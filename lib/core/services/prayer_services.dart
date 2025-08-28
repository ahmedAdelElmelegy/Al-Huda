import 'package:adhan/adhan.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hijri/hijri_calendar.dart';

class PrayerServices {
  final coordinates = Coordinates(30.0444, 31.2357); // القاهرة
  final params = CalculationMethod.egyptian.getParameters();

  PrayerTimes getPrayerTimes() {
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
    final tomorrow = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute + 1,
    );
    return tomorrow.difference(now);
  }
}
