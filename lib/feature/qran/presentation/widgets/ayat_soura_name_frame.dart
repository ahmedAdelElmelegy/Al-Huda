import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:flutter/material.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AyatSouraNameFrame extends StatelessWidget {
  const AyatSouraNameFrame({super.key, required this.surahData});

  final SurahData surahData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(AppImages.titleCover, height: 50.h),
        Text(surahData.name!, style: TextSTyle.f16AmiriBoldPrimary),
      ],
    );
  }
}
