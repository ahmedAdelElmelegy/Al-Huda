import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/custom_appbar_with_arrow.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/settings/presentation/widgets/setting_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTimeDetailScreen extends StatelessWidget {
  const PrayerTimeDetailScreen({super.key});

  static List<String> titles = [
    'fagr'.tr(),
    'dhuhr'.tr(),
    'asr'.tr(),
    'maghrib'.tr(),
    'isha'.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: List.generate(
              5,
              (index) => PrayerTimeDetailItem(title: titles[index]),
            ),
          ),
        ),
      ),
    );
  }
}

class PrayerTimeDetailItem extends StatelessWidget {
  final String title;
  const PrayerTimeDetailItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      color: ColorManager.greyLight,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          SvgIcon(
            assetName: AppIcons.on,
            color: ColorManager.gray,
            width: 20.w,
            height: 20.h,
          ),
          horizontalSpace(8),
          Text(
            title,
            style: TextSTyle.f14CairoSemiBoldPrimary.copyWith(
              color: ColorManager.gray,
            ),
          ),
          horizontalSpace(16),
          Spacer(),
          SettingSwitch(),
        ],
      ),
    );
  }
}
