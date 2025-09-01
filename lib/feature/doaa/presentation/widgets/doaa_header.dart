import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoaaHeader extends StatelessWidget {
  const DoaaHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgIcon(
            assetName: AppIcons.favorite,
            width: 16.w,
            height: 16.h,
            color: ColorManager.white,
          ),
          SvgIcon(
            assetName: AppIcons.copy,
            width: 16.w,
            height: 16.h,
            color: ColorManager.white,
          ),
        ],
      ),
    );
  }
}
