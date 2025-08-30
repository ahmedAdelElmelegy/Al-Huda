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
        color: ColorManager.greyLight,
        // border: Border.all(color: ColorManager.primary),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextSTyle.f16SSTArabicRegBlack),
          child ?? Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
