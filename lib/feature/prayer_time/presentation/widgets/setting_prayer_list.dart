import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/setting_prayer_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPrayerList extends StatelessWidget {
  const SettingPrayerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.4)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: SettingPrayerItem(
            index: index,
            title: Constants.prayer[index].name.tr(),
            icon: Constants.prayer[index].icon,
          ),
        ),
        separatorBuilder: (context, index) =>
            Divider(color: ColorManager.gray.withValues(alpha: 0.2)),
        itemCount: Constants.prayer.length,
      ),
    );
  }
}
