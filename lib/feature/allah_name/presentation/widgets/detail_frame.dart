import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DetailFrame extends StatelessWidget {
  const DetailFrame({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16.h),
          padding: EdgeInsets.symmetric(vertical: 30.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(
              image: AssetImage(AppImages.ribbon1),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              name,
              style: TextSTyle.f16SSTArabicMediumPrimary.copyWith(
                color: ColorManager.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.w,
          left: 0.w,
          child: Image.asset(AppImages.cloudBottom, height: 50.h),
        ),
        Positioned(
          bottom: 0.w,
          right: 0.w,
          child: Image.asset(AppImages.cloudTop, height: 50.h),
        ),
        Positioned(
          bottom: 30.h,
          left: 20.w,
          child: Image.asset(AppImages.leaves, height: 50.h),
        ),
        Positioned(
          top: 20.h,
          right: 20.w,
          child: RotatedBox(
            quarterTurns: 2,
            child: SvgPicture.asset(AppIcons.leave, height: 40.h),
          ),
        ),
      ],
    );
  }
}
