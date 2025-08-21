import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerBanner extends StatelessWidget {
  const HomePrayerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            height: 165.h,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.banner),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
        Positioned(
          left: 30.w,
          top: 20.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('dhuhr'.tr(), style: TextSTyle.f14CairoRegularPrimary),
                  // verticalSpace(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('11:45', style: TextSTyle.f36CairoSemiBoldPrimary),
                      Text('pm'.tr(), style: TextSTyle.f14CairoRegularPrimary),
                    ],
                  ),
                  verticalSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'next_prayer'.tr(),
                        style: TextSTyle.f14CairoRegularPrimary,
                      ),
                      Text('asr'.tr(), style: TextSTyle.f14CairoRegularPrimary),
                    ],
                  ),
                  verticalSpace(4),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('2:50', style: TextSTyle.f14CairoBoldPrimary),
                  Text('pmt'.tr(), style: TextSTyle.f14CairoBoldPrimary),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
