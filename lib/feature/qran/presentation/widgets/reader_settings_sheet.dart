import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReaderSettingsSheet extends StatefulWidget {
  const ReaderSettingsSheet({super.key});

  @override
  State<ReaderSettingsSheet> createState() => _ReaderSettingsSheetState();
}

class _ReaderSettingsSheetState extends State<ReaderSettingsSheet> {
  double _fontSize = 24.0;
  bool _isTafseerEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    // Replace with real settings keys
    final sizeStr =
        await SharedPrefServices.getValue('quran_font_size') ?? '24.0';
    final tafseerStr =
        await SharedPrefServices.getValue('quran_show_tafseer') ?? 'true';
    if (mounted) {
      setState(() {
        _fontSize = double.tryParse(sizeStr) ?? 24.0;
        _isTafseerEnabled = tafseerStr == 'true';
      });
    }
  }

  Future<void> _saveSettings() async {
    await SharedPrefServices.setValue(_fontSize.toString(), 'quran_font_size');
    await SharedPrefServices.setValue(
      _isTafseerEnabled.toString(),
      'quran_show_tafseer',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            verticalSpace(24),

            // Title
            Text(
              'settings'.tr(),
              style: TextSTyle.f18CairoMediumBlack.copyWith(
                color: isDark ? Colors.white : ColorManager.textHigh,
                fontFamily: 'SSTArabicMedium',
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(32),

            // Font Size Section
            Text(
              'font_size'.tr(),
              style: TextSTyle.f16CairoMediumBlack.copyWith(
                color: isDark ? Colors.white70 : ColorManager.textHigh,
              ),
            ),
            verticalSpace(16),
            Row(
              children: [
                Text(
                  'A',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorManager.primary,
                  ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: ColorManager.primary,
                      inactiveTrackColor: ColorManager.primary.withValues(
                        alpha: 0.2,
                      ),
                      thumbColor: ColorManager.primary,
                      overlayColor: ColorManager.primary.withValues(alpha: 0.1),
                      trackHeight: 4.h,
                    ),
                    child: Slider(
                      value: _fontSize,
                      min: 18.0,
                      max: 48.0,
                      divisions: 6,
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                        _saveSettings();
                      },
                    ),
                  ),
                ),
                Text(
                  'A',
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
            verticalSpace(24),

            // Layout specific config
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'show_tafseer'.tr(),
                  style: TextSTyle.f16CairoMediumBlack.copyWith(
                    color: isDark ? Colors.white70 : ColorManager.textHigh,
                  ),
                ),
                Switch.adaptive(
                  value: _isTafseerEnabled,
                  activeThumbColor: ColorManager.primary,
                  onChanged: (value) {
                    setState(() {
                      _isTafseerEnabled = value;
                    });
                    _saveSettings();
                  },
                ),
              ],
            ),
            verticalSpace(24),

            // Done button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'done'.tr(),
                  style: TextStyle(
                    fontFamily: 'SSTArabicMedium',
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
