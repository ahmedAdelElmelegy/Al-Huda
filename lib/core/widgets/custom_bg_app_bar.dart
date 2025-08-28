import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBgAppBar extends StatelessWidget {
  final String bgImage;
  final String logoImage;
  const CustomBgAppBar({
    super.key,
    required this.bgImage,
    required this.logoImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImage),
              fit: BoxFit.cover,
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
          left: 20.w,
          top: 20.h,
          child: GestureDetector(
            onTap: () {
              pop();
            },
            child: SvgIcon(
              assetName: AppIcons.clear,
              color: ColorManager.white,
              height: 16.h,
              width: 16.w,
            ),
          ),
        ),
      ],
    );
  }
}
