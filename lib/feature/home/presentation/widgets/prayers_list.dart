import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/feature/home/presentation/widgets/prayer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayersList extends StatelessWidget {
  const PrayersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      width: double.infinity,
      height: 300.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Align(
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            children: [
              PrayerItem(),
              PrayerItem(),
              PrayerItem(),
              PrayerItem(),
              PrayerItem(),
              PrayerItem(),
              PrayerItem(),
              PrayerItem(),
            ],
          ),
        ),
      ),
    );
  }
}
