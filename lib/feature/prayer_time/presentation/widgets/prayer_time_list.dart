import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/prayer_time_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeList extends StatelessWidget {
  const PrayerTimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.bg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: List.generate(6, (index) => PrayerTimeItem())),
    );
  }
}
