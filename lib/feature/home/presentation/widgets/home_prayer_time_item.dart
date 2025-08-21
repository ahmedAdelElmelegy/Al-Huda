import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerTimeItem extends StatelessWidget {
  final bool isSelected;
  final String prayerTime;
  const HomePrayerTimeItem({
    super.key,
    this.isSelected = false,
    required this.prayerTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            assetName: AppIcons.fagr,
            width: 18.w,
            height: 18.h,
            color: isSelected ? ColorManager.white : ColorManager.primaryText2,
          ),
          verticalSpace(4),
          Text(
            prayerTime.tr(),
            style: isSelected
                ? TextSTyle.f16CairoSemiBoldWhite
                : TextSTyle.f16CairoLightPrimary,
          ),
          verticalSpace(4),
          Text(
            '11.45',
            style: isSelected
                ? TextSTyle.f8CairoSemiBoldWhite
                : TextSTyle.f8CairoLightPrimary,
          ),
        ],
      ),
    );
  }
}
