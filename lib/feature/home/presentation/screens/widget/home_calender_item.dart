import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCalenderItem extends StatelessWidget {
  const HomeCalenderItem({super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();

    return Row(
      children: [
        SvgIcon(
          assetName: AppIcons.calender2,
          width: 18.w,
          height: 18.h,
          color: ColorManager.white,
        ),
        horizontalSpace(8),
        Text(
          PrayerServices.getFormattedGregorianDate(date, context),
          style: TextSTyle.f16AmiriBoldPrimary.copyWith(
            color: ColorManager.white,
          ),
        ),
      ],
    );
  }
}
