import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/prayer_time/presentation/widgets/setting_azkar_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingAzkarList extends StatelessWidget {
  final List<String> azkar;
  const SettingAzkarList({super.key, required this.azkar});

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
        itemCount: azkar.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: SettingAzkarItem(
              title: azkar[index].tr(),
              index: index,
              icon: AppIcons.azkar,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: ColorManager.gray.withValues(alpha: 0.2));
        },
      ),
    );
  }
}
