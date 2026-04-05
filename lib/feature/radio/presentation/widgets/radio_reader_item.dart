import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/radio/data/model/radio_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioReaderItem extends StatelessWidget {
  final RadioData radioData;
  final List<RadioData> radioList;
  const RadioReaderItem({
    super.key,
    required this.radioData,
    required this.radioList,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Radio Logo Hub
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorManager.primary.withValues(alpha: 0.2),
                width: 2,
              ),
              image: DecorationImage(
                image: NetworkImage(radioData.img!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          horizontalSpace(16),
          // Name
          Expanded(
            child: Text(
              radioData.name!,
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 16.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.9)
                    : ColorManager.textHigh,
              ),
            ),
          ),
          // Arrow
          Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 14.sp,
            color: ColorManager.primary.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}
