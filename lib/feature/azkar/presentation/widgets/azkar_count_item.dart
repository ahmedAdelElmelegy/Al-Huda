import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarCountItem extends StatelessWidget {
  final int count;
  const AzkarCountItem({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.primaryText2,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20.r)),
      ),
      child: Text(
        count.toString(),
        style: TextSTyle.f12CairoBoldGrey.copyWith(color: ColorManager.white),
      ),
    );
  }
}
