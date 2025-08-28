import 'package:al_huda/core/helper/app_constants.dart';
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
    QuranReaderModel(name: 'مشاري راشد العفاسي', url: 'ar.alafasy'),
    QuranReaderModel(name: 'محمود خليل الحصري', url: 'ar.husary'),
    QuranReaderModel(name: 'محمد صديق المنشاوي', url: 'ar.minshawi'),
    QuranReaderModel(name: 'أبو بكر الشاطري', url: 'ar.shaatree'),
    QuranReaderModel(name: 'عبد الله بصفر', url: 'ar.abdullahbasfar'),
    QuranReaderModel(name: 'عبد الرحمن السديس', url: 'ar.abdurrahmaansudais'),
    QuranReaderModel(
      name: 'عبد الباسط عبد الصمد (مرتل)',
      url: 'ar.abdulbasitmurattal',
    ),
    QuranReaderModel(name: 'علي الحذيفي', url: 'ar.hudhaify'),
    QuranReaderModel(name: 'ماهر المعيقلي', url: 'ar.mahermuaiqly'),
    QuranReaderModel(name: 'محمد جبريل', url: 'ar.muhammadjibreel'),
  ];
  static String reader = 'reader';
}
