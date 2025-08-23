import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/feature/home/data/model/prayer_model.dart';

class Constants {
  static List<PrayerModel> prayer = [
    PrayerModel(icon: AppIcons.fagr, name: 'fagr'),
    PrayerModel(icon: AppIcons.shroq, name: 'shurooq'),
    PrayerModel(icon: AppIcons.sun, name: 'dhuhr'),
    PrayerModel(icon: AppIcons.cloud, name: 'asr'),
    PrayerModel(icon: AppIcons.magrib, name: 'maghrib'),
    PrayerModel(icon: AppIcons.moon, name: 'isha'),
  ];
}
