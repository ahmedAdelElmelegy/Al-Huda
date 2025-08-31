import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';

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
}
