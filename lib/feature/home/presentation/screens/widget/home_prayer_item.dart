import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  final String time;
  const HomePrayerItem({
    super.key,
    required this.title,
    required this.icon,
    this.isSelected = false,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorManager.primary2
            : Colors.grey.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: !isSelected
              ? ColorManager.primary2.withValues(alpha: .5)
              : Colors.transparent,
        ),
      ),
      padding: EdgeInsets.only(right: 8.w, top: 8.w, bottom: 8.h, left: 8.w),
      child: Column(
        children: [
          Text(
            title.tr(),
            style: TextSTyle.f12AmiriRegPrimary.copyWith(
              color: ColorManager.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(4),
          SvgIcon(
            width: 16.w,
            height: 16.h,
            assetName: icon,
            color: ColorManager.white,
          ),
          verticalSpace(4),
          Text(
            time,
            style: TextSTyle.f12AmiriRegPrimary.copyWith(
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }
}
