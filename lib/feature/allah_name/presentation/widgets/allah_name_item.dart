import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllahNameItem extends StatelessWidget {
  final int index;
  final String name;

  const AllahNameItem({super.key, required this.index, required this.name});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(
          24.r,
        ), // More balanced for smaller grid items
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.1),
          width: 1.2,
        ),
      ),
      child: Stack(
        children: [
          // Index Badge
          Positioned(
            top: 12.h,
            left: 12.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                index.toString(),
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 12.sp,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ),
          // Name Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'AmiriBold',
                      fontSize: 22.sp,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.9)
                          : ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
