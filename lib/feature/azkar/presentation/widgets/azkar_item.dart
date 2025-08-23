import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';

class AzkarItem extends StatelessWidget {
  const AzkarItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: .2),
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(50.r),
        color: ColorManager.primary,
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Center(
            child: Text(
              'azkar_prayer'.tr(),
              style: TextSTyle.f16CairoSemiBoldWhite,
            ),
          ),
          SvgIcon(assetName: AppIcons.sun, color: ColorManager.white),
        ],
      ),
    );
  }
}
