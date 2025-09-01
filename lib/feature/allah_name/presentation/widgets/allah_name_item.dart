import 'package:al_huda/feature/azkar/presentation/widgets/azkar_action_btn.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_content_item.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllahNameItem extends StatelessWidget {
  final int index;
  final String name;
  const AllahNameItem({super.key, required this.index, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorManager.primary, width: .5.w),
        boxShadow: [
          BoxShadow(
            color: ColorManager.gray.withValues(alpha: .2),
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
        color: ColorManager.white,
      ),
      child: Column(
        children: [
          AzkarContentItem(count: index, text: name),
          verticalSpace(24),
          AzkarActionBtn(count: 1, title: name),
        ],
      ),
    );
  }
}
