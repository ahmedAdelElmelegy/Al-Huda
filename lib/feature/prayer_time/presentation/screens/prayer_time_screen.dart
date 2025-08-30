import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/presentation/widgets/home_date_and_location.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/prayer_time.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/custom_app_bar.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/prayer_time_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeScreen extends StatelessWidget {
  const PrayerTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: CustomAppBar(title: 'prayer_time'.tr(), icon: AppIcons.clockA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeDateAndLocation(isPrayerTime: true),
              verticalSpace(20),
              verticalSpace(8),
              Column(
                children: [
                  Column(
                    children: [
                      SvgIcon(
                        assetName: AppIcons.prayer,
                        width: 128.w,
                        height: 128.h,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      verticalSpace(16),
                      PrayerTime(),
                      verticalSpace(20),
                      PrayerTimeList(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
