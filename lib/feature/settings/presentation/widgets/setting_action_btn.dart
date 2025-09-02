import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingActionBtn extends StatelessWidget {
  final Widget? child;
  const SettingActionBtn({super.key, required this.title, this.child});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.gray.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextSTyle.f14SSTArabicMediumPrimary.copyWith(
              color: ColorManager.primaryText2,
            ),
          ),
          child ?? Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
