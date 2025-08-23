import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerItem extends StatelessWidget {
  final String title;
  final String icon;
  const PrayerItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 80.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.primaryBg,
        border: Border.all(color: ColorManager.primary, width: .5.w),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            assetName: icon,
            width: 35.w,
            height: 35.h,
            color: ColorManager.primary,
          ),
          verticalSpace(4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(title, style: TextSTyle.f14CairoSemiBoldPrimary),
          ),
        ],
      ),
    );
  }
}
