import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerBanner extends StatelessWidget {
  const HomePrayerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PrayerCubit>();
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
                  Text(
                    cubit.getCurrentPrayer().tr(),
                    style: TextSTyle.f14CairoRegularPrimary,
                  ),
                  // verticalSpace(4),`
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat(
                          'hh:mm',
                        ).format(cubit.getCurrentPrayerTime()),
                        style: TextSTyle.f36CairoSemiBoldPrimary,
                      ),
                      horizontalSpace(4),
                      Text(
                        PrayerServices.getCurrentAmPm(
                          cubit.getCurrentPrayerTime(),
                        ),
                        style: TextSTyle.f14CairoBoldPrimary,
                      ),
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
                      Text(
                        cubit.nextPrayer.tr(),
                        style: TextSTyle.f14CairoRegularPrimary,
                      ),
                    ],
                  ),
                  verticalSpace(4),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('hh:mm ').format(cubit.nextPrayerTime!),
                    style: TextSTyle.f14CairoBoldPrimary,
                  ),
                  Text(
                    PrayerServices.getNextAmPm(cubit.nextPrayerTime!),
                    style: TextSTyle.f14CairoBoldPrimary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
