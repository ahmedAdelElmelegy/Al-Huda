import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDateAndLocation extends StatelessWidget {
  final bool isPrayerTime;
  const HomeDateAndLocation({super.key, this.isPrayerTime = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('date'.tr(), style: TextSTyle.f12CairoRegGrey),
              verticalSpace(4),
              Text(
                'date2'.tr(),
                style: isPrayerTime
                    ? TextSTyle.f16CairoMediumBlack.copyWith(
                        color: ColorManager.primaryText,
                      )
                    : TextSTyle.f16CairoMediumBlack,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('place'.tr(), style: TextSTyle.f12CairoRegGrey),
              verticalSpace(4),
              Text(
                'location'.tr(),
                style: isPrayerTime
                    ? TextSTyle.f16CairoMediumBlack.copyWith(
                        color: ColorManager.primaryText,
                      )
                    : TextSTyle.f16CairoMediumBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
