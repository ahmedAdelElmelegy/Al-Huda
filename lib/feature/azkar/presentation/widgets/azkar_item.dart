import 'package:al_huda/core/theme/colors.dart';
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
              category.name,
              style: TextSTyle.f16CairoSemiBoldWhite,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
