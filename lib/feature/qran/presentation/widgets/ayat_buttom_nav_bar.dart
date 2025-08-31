import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AyatButtomNavBar extends StatelessWidget {
  final Function()? playPreviousAyah;
  final Function()? playPauseAyah;
  final Function()? playNextAyah;
  final bool isPlaying;
  const AyatButtomNavBar({
    super.key,
    this.playPreviousAyah,
    this.playPauseAyah,
    this.playNextAyah,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(color: ColorManager.primaryBg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: playPreviousAyah,
              child: SvgIcon(
                assetName: AppIcons.skipRight,
                width: 16.sp,
                height: 16.sp,
              ),
            ),
            horizontalSpace(24),
            InkWell(
              onTap: playPauseAyah,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.primaryText2,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.primaryText2.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 24.sp,
                  color: ColorManager.white,
                ),
              ),
            ),
            horizontalSpace(24),
            InkWell(
              onTap: playNextAyah,
              child: SvgIcon(
                assetName: AppIcons.skipLeft,
                width: 16.sp,
                height: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
