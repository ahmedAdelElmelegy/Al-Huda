import 'package:al_huda/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.greyLight2,
      highlightColor: ColorManager.grayMoreLight,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: ColorManager.greyLight2,
        ),
        height: height ?? 60.h,
        width: width ?? double.infinity,
      ),
    );
  }
}
