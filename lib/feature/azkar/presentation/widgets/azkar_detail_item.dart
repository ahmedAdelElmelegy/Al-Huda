import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_action_btn.dart';
import 'package:al_huda/feature/azkar/presentation/widgets/azkar_content_item.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDetailItem extends StatefulWidget {
  final int index;
  final Zikr zikr;
  final bool? isFav;
  final int? zikrIndex;
  final VoidCallback? onCountComplete;

  const AzkarDetailItem({
    super.key,
    required this.index,
    required this.zikr,
    this.isFav = false,
    this.zikrIndex,
    this.onCountComplete,
  });

  @override
  State<AzkarDetailItem> createState() => _AzkarDetailItemState();
}

class _AzkarDetailItemState extends State<AzkarDetailItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorManager.primary, width: .5.w),
        color: ColorManager.white,
      ),
      child: Column(
        children: [
          AzkarContentItem(count: widget.index, text: widget.zikr.text),
          verticalSpace(16),
          AzkarActionBtn(
            count: widget.zikr.count,
            zikr: widget.zikr,
            isFav: widget.isFav,
            index: widget.zikrIndex,
            onCountComplete: widget.onCountComplete,
          ),
        ],
      ),
    );
  }
}
