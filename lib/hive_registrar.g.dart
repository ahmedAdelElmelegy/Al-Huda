import 'package:hive_ce/hive.dart';
import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/tasbeh/data/model/tasbeh_model.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(DoaaModelDataAdapter());
    registerAdapter(SurahDataAdapter());
    registerAdapter(TasbehModelAdapter());
    registerAdapter(ZikrAdapter());
  }
}

extension IsolatedHiveRegistrar on IsolatedHiveInterface {
  void registerAdapters() {
    registerAdapter(DoaaModelDataAdapter());
    registerAdapter(SurahDataAdapter());
    registerAdapter(TasbehModelAdapter());
    registerAdapter(ZikrAdapter());
  }
}
