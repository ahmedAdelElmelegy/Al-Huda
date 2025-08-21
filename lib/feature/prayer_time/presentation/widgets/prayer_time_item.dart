import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeItem extends StatelessWidget {
  const PrayerTimeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          SvgIcon(assetName: AppIcons.sun, color: ColorManager.gray),
          horizontalSpace(8),
          Text(
            'fagr'.tr(),
            style: TextSTyle.f14CairoSemiBoldPrimary.copyWith(
              color: ColorManager.gray,
            ),
          ),
          horizontalSpace(16),
          Spacer(),
          SvgIcon(assetName: AppIcons.on, height: 20.w, width: 20.h),
          horizontalSpace(10),
          Text(
            '04:55',
            style: TextSTyle.f16CairoMediumBlack.copyWith(
              color: ColorManager.gray,
            ),
          ),
        ],
      ),
    );
  }
}
