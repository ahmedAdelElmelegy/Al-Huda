import 'package:al_huda/core/utils/constants.dart';
import 'package:hijri/hijri_calendar.dart';

class CalenderServices {
  static List<Map<String, dynamic>> getEventsWithGregorian({
    required DateTime fromDate,
  }) {
    final nowHijri = HijriCalendar.now();

    return Constants.islamicEvents
        .where((event) {
          HijriCalendar hijriDate = HijriCalendar()
            ..hYear = nowHijri.hYear
            ..hMonth = event.hMonth
            ..hDay = event.hDay;

          DateTime gregorianDate = hijriDate.hijriToGregorian(
            nowHijri.hYear,
            event.hMonth,
            event.hDay,
          );

          return gregorianDate.isAfter(fromDate);
        })
        .map((event) {
          HijriCalendar hijriDate = HijriCalendar()
            ..hYear = nowHijri.hYear
            ..hMonth = event.hMonth
            ..hDay = event.hDay;

          DateTime gregorianDate = hijriDate.hijriToGregorian(
            nowHijri.hYear,
            event.hMonth,
            event.hDay,
          );

          int remainingDays = gregorianDate.difference(fromDate).inDays;

          return {
            "name": event.name,
            "gregorian": gregorianDate,
            "remaining": remainingDays,
          };
        })
        .toList();
  }

  static List<Map<String, dynamic>> getGregorianEvents({
    required DateTime fromDate,
  }) {
    final List<Map<String, dynamic>> events = [];

    final christmas = DateTime(fromDate.year, 12, 25);
    if (christmas.isAfter(fromDate)) {
      events.add({
        "name": "eid_al_melad",
        "gregorian": christmas,
        "remaining": christmas.difference(fromDate).inDays,
      });
    }

    final newYear = DateTime(fromDate.year + 1, 1, 1);
    if (newYear.isAfter(fromDate)) {
      events.add({
        "name": "new_year",
        "gregorian": newYear,
        "remaining": newYear.difference(fromDate).inDays,
      });
    }

    return events;
  }

  // convet to arabic
  static String toArabicNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'\d'),
      (match) => '٠١٢٣٤٥٦٧٨٩'[int.parse(match[0]!)],
    );
  }
}
