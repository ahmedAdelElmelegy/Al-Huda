import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AyatSouraNameFrame extends StatelessWidget {
  const AyatSouraNameFrame({super.key, required this.surahData});

  final SurahData surahData;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorManager.primary.withValues(alpha: isDark ? 0.3 : 0.8),
            ColorManager.primary.withValues(alpha: isDark ? 0.1 : 0.6),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Icon Pattern
          Positioned(
            right: -20,
            bottom: -30,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(AppImages.qranIcon, width: 120.w, color: Colors.white),
            ),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                surahData.name ?? '',
                style: TextSTyle.f36CairoSemiBoldPrimary.copyWith(
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              Text(
                surahData.englishNameTranslation ?? '',
                style: TextSTyle.f12CairoSemiBoldWhite.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              verticalSpace(16),
              Container(
                width: 200.w,
                height: 1,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              verticalSpace(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    surahData.revelationType == 'Meccan' ? 'مكية'.tr() : 'مدنية'.tr(),
                    style: TextSTyle.f12CairoSemiBoldWhite,
                  ),
                  horizontalSpace(8),
                  Container(
                    width: 4.w,
                    height: 4.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  horizontalSpace(8),
                  Text(
                    '${surahData.numberOfAyahs} ${'ayah'.tr()}',
                    style: TextSTyle.f12CairoSemiBoldWhite,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
