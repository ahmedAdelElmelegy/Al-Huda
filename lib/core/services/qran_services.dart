import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/surah_model_data.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class QranServices {
  static List<Widget> buildPageSeparators(List<Ayah> ayatList) {
    List<Widget> separators = [];
    for (int i = 0; i < ayatList.length - 1; i++) {
      final currentAyah = ayatList[i];
      final nextAyah = ayatList[i + 1];

      if (currentAyah.page != nextAyah.page) {
        separators.add(
          Column(
            children: [
              verticalSpace(12),
              Divider(color: ColorManager.gray, thickness: 1),
              Text(
                "الصفحة ${currentAyah.page}",
                style: TextSTyle.f16AmiriBoldPrimary.copyWith(
                  fontSize: 18.sp,
                  color: ColorManager.primaryText2,
                ),
              ),
              verticalSpace(12),
            ],
          ),
        );
      }
    }

    if (ayatList.isNotEmpty) {
      separators.add(
        Column(
          children: [
            verticalSpace(12),
            Divider(color: ColorManager.gray, thickness: 1),
            Text(
              "الصفحة ${ayatList.last.page}",
              style: TextSTyle.f16AmiriBoldPrimary.copyWith(
                fontSize: 18.sp,
                color: ColorManager.primaryText2,
              ),
            ),
            verticalSpace(12),
          ],
        ),
      );
    }

    return separators;
  }

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
}
