import 'package:al_huda/core/utils/constants.dart';
import 'package:hijri/hijri_calendar.dart';

class CalenderServices {
  static List<Map<String, dynamic>> getEventsWithGregorian({
    required DateTime fromDate,
  }) {
    final nowHijri = HijriCalendar.now();

    return Constants.islamicEvents.map((event) {
      int hYear = nowHijri.hYear;

      HijriCalendar hijriDate = HijriCalendar()
        ..hYear = hYear
        ..hMonth = event.hMonth
        ..hDay = event.hDay;

      DateTime gregorianDate = hijriDate.hijriToGregorian(
        hYear,
        event.hMonth,
        event.hDay,
      );

      if (gregorianDate.isBefore(fromDate)) {
        HijriCalendar nextHijri = HijriCalendar()
          ..hYear = hYear + 1
          ..hMonth = event.hMonth
          ..hDay = event.hDay;

        gregorianDate = nextHijri.hijriToGregorian(
          nextHijri.hYear,
          nextHijri.hMonth,
          nextHijri.hDay,
        );
      }

      int remainingDays = gregorianDate.difference(fromDate).inDays;

      return {
        "name": event.name,
        "gregorian": gregorianDate,
        "remaining": remainingDays,
      };
    }).toList();
  }

  static List<Map<String, dynamic>> getGregorianEvents({
    required DateTime fromDate,
  }) {
    final List<Map<String, dynamic>> events = [];

    final christmas = DateTime(fromDate.year, 12, 25);
    events.add({
      "name": "عيد الميلاد",
      "gregorian": christmas,
      "remaining": christmas.difference(fromDate).inDays,
    });

    final newYear = DateTime(fromDate.year + 1, 1, 1);
    events.add({
      "name": "رأس السنة",
      "gregorian": newYear,
      "remaining": newYear.difference(fromDate).inDays,
    });

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
