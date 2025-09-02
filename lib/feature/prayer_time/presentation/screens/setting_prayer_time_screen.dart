import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/setting_prayer_list.dart';

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
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: ColorManager.primaryBg,
                  child: Icon(
                    Icons.notifications_active_outlined,
                    size: 30.sp,
                    color: ColorManager.primary,
                  ),
                ),
                verticalSpace(16),
                Text(
                  'active_notification_prayer'.tr(),
                  style: TextSTyle.f16SSTArabicMediumPrimary,
                ),
                verticalSpace(10),
                Text(
                  'notification_prayer'.tr(),
                  style: TextSTyle.f12CairoRegGrey,
                ),
                verticalSpace(10),
                SettingPrayerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
