import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllPrayersHeadline extends StatelessWidget {
  const AllPrayersHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'all_features'.tr(),
        style: TextSTyle.f18CairoBoldWhite.copyWith(
          color: ColorManager.primary2,
        ),
      ),
    );
  }
}
