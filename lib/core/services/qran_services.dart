import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/surah_model_data.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class QranServices {
  // open box
  static const String boxName = Constants.surahBoxName;

  // create box
  Future<Box<SurahData>> openBox() async {
    return await Hive.openBox<SurahData>(boxName);
  }

  // add soura to hive
  Future<void> addSouraToHive(List<SurahData> surahList) async {
    final box = await openBox();
    await box.addAll(surahList);
  }

  // get all soura from hive
  Future<List<SurahData>> getAllSouraFromHive() async {
    final box = await openBox();
    return box.values.toList();
  }

  //

  static const String ayatBoxName = Constants.ayatBoxName;

  Future<Box<SurahModelData>> openBoxAyah() async {
    try {
      return await Hive.openBox<SurahModelData>(ayatBoxName);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAyahOfSoura(SurahModelData surahModelData) async {
    final box = await openBoxAyah();
    await box.put(surahModelData.number, surahModelData);
  }

  Future<SurahModelData?> getAllAyahFromHive(int surahNumber) async {
    final box = await openBoxAyah();
    return box.get(surahNumber);
  }

  // dounload ayat
  // add last sura and ayah to hive
}
