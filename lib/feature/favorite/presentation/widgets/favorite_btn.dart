import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteBtn extends StatelessWidget {
  final bool selectIndex;
  final String title;
  const FavoriteBtn({
    super.key,
    required this.selectIndex,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: !selectIndex
            ? Border.all(color: ColorManager.primary, width: .5.w)
            : null,
        color: selectIndex ? ColorManager.primary : ColorManager.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextSTyle.f14SSTArabicBoldWhite.copyWith(
          color: selectIndex ? ColorManager.white : ColorManager.primary,
        ),
      ),
    );
  }
}
