import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SurahItem extends StatelessWidget {
  final SurahData surahData;
  final bool isEven;
  final bool isDark;

  const SurahItem({
    super.key,
    required this.surahData,
    this.isEven = true,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        border: Border(
          bottom: BorderSide(
            color: ColorManager.primary.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Decorative number badge ────────────────────────────────
          _OctagonBadge(number: surahData.number ?? 0, isDark: isDark),
          horizontalSpace(16),

          // ── Surah name ─────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surahData.name ?? '',
                  style: TextStyle(
                    fontFamily: 'AmiriBold',
                    fontSize: 20.sp, // More present
                    color: isDark
                        ? ColorManager.textHighDark
                        : ColorManager.textHigh,
                    height: 1.2,
                  ),
                ),
                verticalSpace(4),
                Text(
                  '${surahData.numberOfAyahs} ${'ayatha'.tr()}',
                  style: TextStyle(
                    fontFamily: 'SSTArabicRoman',
                    fontSize: 12.sp,
                    color: ColorManager.textLight.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),

          // ── Revelation badge ───────────────────────────────────────
          _RevelationBadge(
            type: surahData.revelationType ?? '',
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

// ─── Octagonal Number Badge ───────────────────────────────────────────────────

class _OctagonBadge extends StatelessWidget {
  final int number;
  final bool isDark;
  const _OctagonBadge({required this.number, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: ColorManager.primary.withValues(alpha: isDark ? 0.2 : 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorManager.primary.withValues(alpha: 0.15),
          width: 1.2,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 14.sp,
            color: ColorManager.primary,
          ),
        ),
      ),
    );
  }
}

// ─── Revelation Badge ─────────────────────────────────────────────────────────

class _RevelationBadge extends StatelessWidget {
  final String type;
  final bool isDark;
  const _RevelationBadge({required this.type, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isMeccan = type == 'Meccan';
    final label = isMeccan ? 'maka'.tr() : 'medina'.tr();
    final color = isMeccan ? Color(0xFFD4A017) : ColorManager.primary;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'SSTArabicMedium',
          fontSize: 11.sp,
          color: isDark ? color.withValues(alpha: 0.8) : color,
        ),
      ),
    );
  }
}
