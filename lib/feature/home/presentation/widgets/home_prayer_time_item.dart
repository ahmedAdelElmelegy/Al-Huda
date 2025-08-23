import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/data/model/prayer_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerTimeItem extends StatelessWidget {
  final bool isSelected;
  final PrayerModel prayerTime;
  final String time;
  const HomePrayerTimeItem({
    super.key,
    this.isSelected = false,
    required this.prayerTime,
    required this.time,
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
            assetName: prayerTime.icon,
            width: 24.w,
            height: 24.h,
            color: isSelected ? ColorManager.white : ColorManager.primaryText2,
          ),
          verticalSpace(4),
          Text(
            tr(prayerTime.name),
            style: isSelected
                ? TextSTyle.f16CairoSemiBoldWhite
                : TextSTyle.f16CairoLightPrimary,
          ),
          verticalSpace(5),
          Text(
            time,
            style: isSelected
                ? TextSTyle.f12CairoSemiBoldWhite
                : TextSTyle.f12CairoSemiBoldPrimary,
          ),
        ],
      ),
    );
  }
}
