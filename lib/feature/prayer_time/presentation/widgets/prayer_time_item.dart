import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/data/model/prayer_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeItem extends StatelessWidget {
  final PrayerModel prayer;
  final bool? isSelected;
  final String time;
  const PrayerTimeItem({
    super.key,
    required this.prayer,
    this.isSelected = false,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: isSelected == true ? ColorManager.primaryBg : Colors.transparent,
      ),
      child: Row(
        children: [
          SvgIcon(
            assetName: prayer.icon,
            color: isSelected == true
                ? ColorManager.primary
                : ColorManager.gray,
          ),
          horizontalSpace(8),
          Text(
            prayer.name.tr(),
            style: TextSTyle.f14CairoSemiBoldPrimary.copyWith(
              color: isSelected == true
                  ? ColorManager.primary
                  : ColorManager.gray,
            ),
          ),
          horizontalSpace(16),
          Spacer(),
          SvgIcon(
            assetName: AppIcons.on,
            height: 20.w,
            width: 20.h,
            color: isSelected == true
                ? ColorManager.primary
                : ColorManager.gray,
          ),
          horizontalSpace(10),
          Text(
            time,
            style: TextSTyle.f16CairoMediumBlack.copyWith(
              color: isSelected == true
                  ? ColorManager.primary
                  : ColorManager.gray,
            ),
          ),
        ],
      ),
    );
  }
}
