import 'package:al_huda/feature/azkar/presentation/widgets/azkar_count_item.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AzkarContentItem extends StatelessWidget {
  final int count;
  const AzkarContentItem({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),

        color: ColorManager.primaryBg,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              AzkarCountItem(count: count),
              Center(child: SvgPicture.asset(AppIcons.azkarTop, height: 16.h)),
            ],
          ),
          verticalSpace(16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Text(
                'doaa_card'.tr(),
                style: TextSTyle.f16AmiriRegPrimary,
              ),
            ),
          ),
          verticalSpace(16),
          SvgPicture.asset(AppIcons.azkarButton, height: 16.h),
          verticalSpace(16),
        ],
      ),
    );
  }
}
