import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/azkar/data/model/azkar_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:al_huda/core/theme/style.dart';

class AzkarItem extends StatelessWidget {
  final AzkarCategory category;
  const AzkarItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.primary, width: .5.w),
        borderRadius: BorderRadius.circular(12.r),
        color: ColorManager.primaryBg,
      ),
      child: Row(
        children: [
          SvgIcon(
            assetName: AppIcons.azkar,
            color: ColorManager.blue,
            width: 20.w,
            height: 20.h,
          ),
          horizontalSpace(8),
          Container(
            height: 20.h,
            width: 1.w,
            decoration: BoxDecoration(
              color: ColorManager.blue.withValues(alpha: .2),
            ),
          ),
          horizontalSpace(8),
          Text(
            category.name,
            style: TextSTyle.f16AmiriBoldPrimary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
