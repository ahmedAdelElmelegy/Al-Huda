import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/qran/presentation/widgets/reader_settings_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AyatAppBar extends StatelessWidget {
  final SurahData surahData;
  final VoidCallback? onSettingsClosed;
  const AyatAppBar({super.key, required this.surahData, this.onSettingsClosed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.surfaceDark : ColorManager.primaryBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorManager.primary,
              size: 20.sp,
            ),
          ),
        ),
        Text(
          surahData.englishName ?? '',
          style: TextSTyle.f18CairoBoldWhite.copyWith(
            color: isDark ? Colors.white : ColorManager.textHigh,
          ),
        ),
        GestureDetector(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => const ReaderSettingsSheet(),
            );
            if (onSettingsClosed != null) {
              onSettingsClosed!();
            }
          },
          child: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.surfaceDark : ColorManager.primaryBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.tune_rounded,
              color: ColorManager.primary,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
