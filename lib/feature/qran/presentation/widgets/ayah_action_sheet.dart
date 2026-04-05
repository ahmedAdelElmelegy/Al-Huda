import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/hifz/presentation/manager/hifz_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/audio/audio_player_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class AyahActionSheet extends StatelessWidget {
  final Ayah ayah;
  final SurahData surahData;
  final String cleanAyahText;

  const AyahActionSheet({
    super.key,
    required this.ayah,
    required this.surahData,
    required this.cleanAyahText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        top: 8.h,
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).padding.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.backgroundDark : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorManager.gray.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          verticalSpace(16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${surahData.name} - ${'ayah'.tr()} ${ayah.numberInSurah}',
                style: TextSTyle.f18CairoBoldWhite.copyWith(
                  color: isDark ? Colors.white : ColorManager.textHigh,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close_rounded, color: ColorManager.gray),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          verticalSpace(8),

          // Preview
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: isDark ? ColorManager.surfaceDark : ColorManager.primaryBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              cleanAyahText,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextSTyle.f16UthmanicHafs1Primary.copyWith(
                color: isDark ? Colors.white : ColorManager.textHigh,
              ),
            ),
          ),
          verticalSpace(24),

          // Actions
          Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            alignment: WrapAlignment.center,
            children: [
              _ActionTile(
                icon: Icons.play_arrow_rounded,
                label: 'play'.tr(),
                color: ColorManager.accent,
                onTap: () {
                  Navigator.pop(context);
                  context.read<AudioPlayerCubit>().playAyahAudio(ayah.numberInSurah);
                },
              ),
              _ActionTile(
                icon: Icons.copy_rounded,
                label: 'copy'.tr(),
                color: ColorManager.blue,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: '$cleanAyahText ﴿${ayah.numberInSurah}﴾ [${surahData.name}]'));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('copied_to_clipboard'.tr())),
                  );
                },
              ),
              _ActionTile(
                icon: Icons.share_rounded,
                label: 'share'.tr(),
                color: Colors.purple,
                onTap: () {
                  // ignore: deprecated_member_use
                  Share.share('$cleanAyahText ﴿${ayah.numberInSurah}﴾ [${surahData.name}]');
                  Navigator.pop(context);
                },
              ),
              _ActionTile(
                icon: Icons.favorite_border_rounded,
                label: 'mark_as_memorized'.tr(),
                color: ColorManager.success,
                onTap: () {
                  context.read<HifzCubit>().markAsMemorized(
                        surahData.number ?? 1,
                        ayah.numberInSurah,
                      );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('mark_as_memorized'.tr())),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 70.w,
        child: Column(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            verticalSpace(8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextSTyle.f12CairoSemiBoldPrimary.copyWith(
                color: isDark ? ColorManager.textHighDark : ColorManager.textMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
