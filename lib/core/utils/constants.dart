import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/feature/calender/data/model/islamic_model.dart';
import 'package:al_huda/feature/home/data/model/prayer_model.dart';
import 'package:al_huda/feature/qran/data/model/qran_reader_model.dart';

class Constants {
  static List<PrayerModel> prayer = [
    PrayerModel(icon: AppIcons.fagr, name: 'fagr'),
    PrayerModel(icon: AppIcons.shroq, name: 'shurooq'),
    PrayerModel(icon: AppIcons.sun, name: 'dhuhr'),
    PrayerModel(icon: AppIcons.cloud, name: 'asr'),
    PrayerModel(icon: AppIcons.magrib, name: 'maghrib'),
    PrayerModel(icon: AppIcons.moon, name: 'isha'),
  ];
  static List<QuranReaderModel> quranReader = [
    QuranReaderModel(
      name: 'مشاري راشد العفاسي',
      url: 'ar.alafasy',
      number: 128,
    ),
    QuranReaderModel(name: 'محمود خليل الحصري', url: 'ar.husary', number: 128),
    QuranReaderModel(
      name: 'محمد صديق المنشاوي',
      url: 'ar.minshawi',
      number: 128,
    ),
    QuranReaderModel(name: 'أبو بكر الشاطري', url: 'ar.shaatree', number: 128),
    QuranReaderModel(
      name: 'عبد الله بصفر',
      url: 'ar.abdullahbasfar',
      number: 192,
    ),
    QuranReaderModel(
      name: 'عبد الرحمن السديس',
      url: 'ar.abdurrahmaansudais',
      number: 192,
    ),
    QuranReaderModel(
      name: 'عبد الباسط عبد الصمد (مرتل)',
      url: 'ar.abdulbasitmurattal',
      number: 192,
    ),
    QuranReaderModel(name: 'علي الحذيفي', url: 'ar.hudhaify', number: 128),
    QuranReaderModel(
      name: 'ماهر المعيقلي',
      url: 'ar.mahermuaiqly',
      number: 128,
    ),
    QuranReaderModel(
      name: 'محمد جبريل',
      url: 'ar.muhammadjibreel',
      number: 128,
    ),
  ];
  static String reader = 'reader';
  static String lat = 'lat';
  static String lng = 'lng';
  static const keyPrefix = "prayer_switch_";
  static const keyPrefixNotification = "prayer_switch_notification_";
  static List<String> azkar = ["azkar_sabah", "azkar_massaa"];
  static const keyPrefixAzkar = "azkar_switch_";
  static const azkarKeySabah = "time_أذكار الصباح";
  static const azkarKeyMassaa = "time_أذكار المساء";
  static const onlyOneAzkarNotification = "only_one_azkar_notification";
  static const azkarsalleyalmohamed = "azkar_salley_al_mohamed";
  static const azkarAlsabahChannelId = "azkar_sabah_channel";
  static const azkarElmassaaChannelId = "azkar_massaa_channel";
  static const saleAlMohamedChannelId = "sale_al_mohamed_channel";
  static const zikrBoxName = "zikrBox";
  static const doaaBoxName = "doaaBox";
  static const surahBoxName = "surahBox";
  static const ayatBoxName = "ayatBox";
  static List<IslamicEvent> islamicEvents = [
    IslamicEvent(name: "رأس السنة الهجرية", hMonth: 1, hDay: 1),
    IslamicEvent(name: "عاشوراء", hMonth: 1, hDay: 10),
    IslamicEvent(name: "المولد النبوي", hMonth: 3, hDay: 12),
    IslamicEvent(name: "بداية رمضان", hMonth: 9, hDay: 1),
    IslamicEvent(name: "ليلة القدر", hMonth: 9, hDay: 27),
    IslamicEvent(name: "عيد الفطر", hMonth: 10, hDay: 1),
    IslamicEvent(name: "يوم عرفة", hMonth: 12, hDay: 9),
    IslamicEvent(name: "عيد الأضحى", hMonth: 12, hDay: 10),
  ];
  static List<String> doaaNameList = [
    "doaa_form_qran_karem",
    "doaa_from_sonaa_nabweya",
    "alroqia_sharia",
  ];
}
