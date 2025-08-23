import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDescription extends StatelessWidget {
  const AzkarDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'description'.tr(),
        style: TextSTyle.f12CairoRegGrey.copyWith(
          color: ColorManager.primaryText2,
        ),
      ),
    );
  }
}
