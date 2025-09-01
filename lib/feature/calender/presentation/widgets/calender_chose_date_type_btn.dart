import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class CalenderChoseDateTypeBtn extends StatelessWidget {
  final String title;
  final bool isSelected;
  const CalenderChoseDateTypeBtn({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isSelected ? ColorManager.primary : ColorManager.greyLight,
      ),
      child: Text(
        title.tr(),
        style: isSelected
            ? TextSTyle.f18SSTArabicMediumPrimary.copyWith(color: Colors.white)
            : TextSTyle.f18SSTArabicRegPrimary.copyWith(color: Colors.grey),
      ),
    );
  }
}
