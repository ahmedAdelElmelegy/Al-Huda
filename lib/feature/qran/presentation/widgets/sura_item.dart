import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/widgets/qran_number_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurahItem extends StatelessWidget {
  final SurahData surahData;
  const SurahItem({super.key, required this.surahData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorManager.primaryText2.withValues(alpha: 0.1),
          ),
        ),
        color: ColorManager.primaryBg,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QranNumberItem(number: surahData.number!),
          horizontalSpace(10),
          Text(surahData.name!, style: TextSTyle.f16AmiriBoldPrimary),
          Spacer(),
          Column(
            children: [
              Text('ayatha'.tr(), style: TextSTyle.f16AmiriBoldPrimary),
              Text(
                surahData.numberOfAyahs.toString(),
                style: TextSTyle.f16AmiriBoldPrimary,
              ),
            ],
          ),
          horizontalSpace(12),
          SvgIcon(assetName: getRevelationType(), width: 24.w, height: 24.h),
        ],
      ),
    );
  }

  String getRevelationType() {
    switch (surahData.revelationType) {
      case 'Meccan':
        return AppIcons.maka;
      case 'Medinan':
        return AppIcons.medina;
      default:
        return '';
    }
  }
}
