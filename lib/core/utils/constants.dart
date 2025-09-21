import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/feature/allah_name/presentation/screens/allah_name_screen.dart';
import 'package:al_huda/feature/azkar/presentation/screens/azkar_screen.dart';
import 'package:al_huda/feature/calender/data/model/islamic_model.dart';
import 'package:al_huda/feature/calender/presentation/screens/calender_screen.dart';
import 'package:al_huda/feature/doaa/presentation/screens/doaa_screen.dart';
import 'package:al_huda/feature/favorite/presentation/screens/favorite_screen.dart';
import 'package:al_huda/feature/home/data/model/prayer_model.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/screens/nearest_mosque_screen.dart';
import 'package:al_huda/feature/qran/data/model/qran_reader_model.dart';
import 'package:al_huda/feature/radio/presentation/screens/radio_screen.dart';
import 'package:al_huda/feature/tasbeh/presentation/screens/tasbeh_screen.dart';

class Constants {
  static List<PrayerModel> prayer = [
    PrayerModel(icon: AppIcons.fagr, name: 'fagr'),
    PrayerModel(icon: AppIcons.shroq, name: 'shurooq'),
    PrayerModel(icon: AppIcons.sun, name: 'dhuhr'),
    PrayerModel(icon: AppIcons.cloud, name: 'asr'),
    PrayerModel(icon: AppIcons.magrib, name: 'maghrib'),
    PrayerModel(icon: AppIcons.moon, name: 'isha'),
  ];
  static const String completePrayer = 'completePrayer';
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
  static const lastQuranSuraAndAyah = "last_quran_sura_and_ayah";
  static const zikrBoxName = "zikrBox";
  static const doaaBoxName = "doaaBox";
  static const surahBoxName = "surahBox";
  static const ayatBoxName = "ayatBox";
  static List<IslamicEvent> islamicEvents = [
    IslamicEvent(name: "events.new_year", hMonth: 1, hDay: 1),
    IslamicEvent(name: "events.ashura", hMonth: 1, hDay: 10),
    IslamicEvent(name: "events.mawlid", hMonth: 3, hDay: 12),
    IslamicEvent(name: "events.ramadan_start", hMonth: 9, hDay: 1),
    IslamicEvent(name: "events.laylat_al_qadr", hMonth: 9, hDay: 27),
    IslamicEvent(name: "events.eid_al_fitr", hMonth: 10, hDay: 1),
    IslamicEvent(name: "events.arafah", hMonth: 12, hDay: 9),
    IslamicEvent(name: "events.eid_al_adha", hMonth: 12, hDay: 10),
  ];

  static List<String> doaaNameList = [
    "doaa_form_qran_karem",
    "doaa_from_sonaa_nabweya",
    "alroqia_sharia",
  ];
  static String qranFontSize = 'qranFontSize';
  static String language = 'language';
  static List<PrayerModel> homePrayerCategory = [
    PrayerModel(name: 'azkar', icon: AppIcons.salah, screen: AzkarScreen()),
    PrayerModel(name: 'tasbeh', icon: AppIcons.tasbih, screen: TasbehScreen()),
    PrayerModel(name: 'radio', icon: AppIcons.radio, screen: RadioScreen()),
    PrayerModel(
      name: 'allah_name',
      icon: AppIcons.allah,
      screen: AllahNameScreen(),
    ),
    PrayerModel(
      name: 'nearest_mosque',
      icon: AppIcons.mosque,
      screen: NearestMosqueScreen(),
    ),
    PrayerModel(
      name: 'hijri_date',
      icon: AppIcons.callender,
      screen: CalenderScreen(),
    ),
    PrayerModel(name: 'doaa', icon: AppIcons.alldoaa, screen: DoaaScreen()),
    PrayerModel(
      name: 'favorite',
      icon: AppIcons.favorite,
      screen: FavoriteScreen(),
    ),
  ];
}
