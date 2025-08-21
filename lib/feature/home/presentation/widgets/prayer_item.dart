import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerItem extends StatelessWidget {
  const PrayerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorManager.primaryBg,
        border: Border.all(color: ColorManager.primary, width: .5.w),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          SvgIcon(assetName: AppIcons.salah, width: 35.w, height: 35.h),
          verticalSpace(4),
          Text('azkar', style: TextSTyle.f14CairoSemiBoldPrimary),
        ],
      ),
    );
  }
}
