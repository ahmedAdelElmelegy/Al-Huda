import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppBar extends StatelessWidget {
  final String title;
  const DefaultAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: .5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        color: ColorManager.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.r),
          bottomRight: Radius.circular(50.r),
        ),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned(
            right: 8.w,
            child: IconButton(
              onPressed: () {
                pop();
              },
              icon: Icon(Icons.arrow_back, color: ColorManager.white),
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextSTyle.f24CairoSemiBoldPrimary.copyWith(
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
