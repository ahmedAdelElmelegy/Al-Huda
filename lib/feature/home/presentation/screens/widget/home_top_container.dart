import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_calender_item.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_location.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_next_prayer.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_remaing_time.dart';
import 'package:al_huda/feature/home/presentation/widgets/home_all_prayer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomTopContainer extends StatelessWidget {
  const HomTopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary2.withValues(alpha: .8),
        image: DecorationImage(
          image: AssetImage(AppImages.home),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(16),
                HomeCalenderItem(),

                verticalSpace(8),
                HomeNextPrayer(),
              ],
            ),
            verticalSpace(16),
            HomeRemaingTime(),
            verticalSpace(8),
            HomeLocation(),
            verticalSpace(24),
            HomeAllPrayerList(),
          ],
        ),
      ),
    );
  }
}
