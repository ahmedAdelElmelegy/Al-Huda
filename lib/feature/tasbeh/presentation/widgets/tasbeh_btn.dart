import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasbehBtn extends StatelessWidget {
  const TasbehBtn({
    super.key,
    required this.text,
    this.onPressed,
    this.color,
    this.radiusDirection,
    this.isFullRadius = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final bool? radiusDirection;
  final bool? isFullRadius;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: isFullRadius == true
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                )
              : radiusDirection == true
              ? BorderRadius.only(bottomRight: Radius.circular(24.r))
              : BorderRadius.only(bottomLeft: Radius.circular(24.r)),
          color: color ?? ColorManager.blue,
        ),
        child: Text(
          text,
          style: TextSTyle.f14CairoRegularPrimary.copyWith(
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }
}
