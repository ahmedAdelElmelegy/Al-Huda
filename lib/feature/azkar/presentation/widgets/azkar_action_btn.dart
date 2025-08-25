import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarActionBtn extends StatelessWidget {
  final int count;
  const AzkarActionBtn({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgIcon(assetName: AppIcons.heart),
        horizontalSpace(24),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorManager.primary, width: 2),

            color: ColorManager.white,
          ),
          child: Text(
            count.toString(),
            style: TextSTyle.f14CairoBoldPrimary.copyWith(
              color: ColorManager.primary,
            ),
          ),
        ),
        horizontalSpace(24),

        SvgIcon(assetName: AppIcons.share),
      ],
    );
  }
}
