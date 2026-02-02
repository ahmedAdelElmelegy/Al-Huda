import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrayerTrackerItem extends StatelessWidget {
  final String title;
  final String time;
  final bool isSelected;
  const PrayerTrackerItem({
    super.key,
    required this.title,
    required this.time,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.tr(), style: TextSTyle.f14SSTArabicMediumPrimary),
              verticalSpace(4),
              Text(time, style: TextSTyle.f12SSTArabicRegBlack),
            ],
          ),
        ),
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Checkbox(
            shape: const CircleBorder(),
            checkColor: ColorManager.white,
            activeColor: ColorManager.primary,
            value: isSelected,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
