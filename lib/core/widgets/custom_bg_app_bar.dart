import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBgAppBar extends StatelessWidget {
  final String bgImage;
  final String logoImage;
  final String title;
  const CustomBgAppBar({
    super.key,
    required this.bgImage,
    required this.logoImage,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManager.primary,
            gradient: LinearGradient(
              colors: [
                ColorManager.primary,
                ColorManager.primary.withValues(alpha: .8),
                ColorManager.primary.withValues(alpha: .5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          right: 20.w,
          top: 50.h,
          child: Text(
            title.tr(),
            style: TextSTyle.f30SSTArabicMediumPrimary.copyWith(
              color: ColorManager.white,
            ),
          ),
        ),
        Positioned(
          left: 20.w,
          bottom: 20.h,
          child: Image.asset(AppImages.cloudBottom, fit: BoxFit.cover),
        ),
        Positioned(
          left: 40.w,
          top: 5.h,
          child: Image.asset(
            logoImage,
            fit: BoxFit.cover,
            width: 100.w,
            // height: 100.h,
          ),
        ),
        Positioned(
          right: 20.w,
          top: 20.h,
          child: GestureDetector(
            onTap: () {
              pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorManager.white,
              size: 24.sp,
            ),
          ),
        ),
      ],
    );
  }
}
