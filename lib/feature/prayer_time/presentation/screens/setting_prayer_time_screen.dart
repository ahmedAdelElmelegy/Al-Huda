import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';

import 'package:al_huda/feature/prayer_time/presentation/widgets/prayer_time_detail_item.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPrayerTimeScreen extends StatelessWidget {
  const SettingPrayerTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: 'prayer_time'.tr()),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              children: List.generate(
                Constants.prayer.length,
                (index) => PrayerTimeDetailItem(
                  index: index,
                  title: Constants.prayer[index].name.tr(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
