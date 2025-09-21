import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/data/model/prayer_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCategoryItem extends StatelessWidget {
  final PrayerModel prayer;
  const HomeCategoryItem({super.key, required this.prayer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorManager.accent.withValues(alpha: .3),
            ),
            child: SvgIcon(
              assetName: prayer.icon,
              width: 20.w,
              height: 20.h,
              color: ColorManager.primary2,
            ),
          ),
          verticalSpace(8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              prayer.name.tr(),
              style: TextSTyle.f12SSTArabicMediumBlack.copyWith(
                color: ColorManager.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
