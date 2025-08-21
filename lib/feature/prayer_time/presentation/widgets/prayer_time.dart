import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('remaining_time'.tr(), style: TextSTyle.f12CairoRegGrey),
            verticalSpace(4),
            Text(
              '${'for_prayer'.tr()} ${'fagr'.tr()}',
              style: TextSTyle.f14CairoBoldPrimary.copyWith(
                color: ColorManager.primaryText,
              ),
            ),
          ],
        ),
        horizontalSpace(16),
        Text('04:55 -', style: TextSTyle.f20CairoLightGrey),
      ],
    );
  }
}
