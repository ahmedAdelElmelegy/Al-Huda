import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/qran/presentation/manager/audio/audio_player_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AudioPlayerBar extends StatelessWidget {
  final int totalAyahs;

  const AudioPlayerBar({
    super.key,
    required this.totalAyahs,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
      builder: (context, state) {
        if (!state.isPlaying && state.currentlyPlayingAyah == null && !state.isLoading) {
          return const SizedBox.shrink();
        }

        double progress = 0;
        if (totalAyahs > 0 && state.currentAyahIndex >= 0) {
          progress = (state.currentAyahIndex + 1) / totalAyahs;
        }

        return Container(
          margin: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).padding.bottom + 16.h,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: isDark
                ? ColorManager.surfaceDark.withValues(alpha: 0.95)
                : Colors.white.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: ColorManager.primary.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : ColorManager.primary.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Info & Controls Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Playback Speed
                  GestureDetector(
                    onTap: () {
                      final cubit = context.read<AudioPlayerCubit>();
                      double nextSpeed;
                      if (state.playbackSpeed == 1.0) { nextSpeed = 1.25; }
                      else if (state.playbackSpeed == 1.25) { nextSpeed = 1.5; }
                      else if (state.playbackSpeed == 1.5) { nextSpeed = 0.75; }
                      else { nextSpeed = 1.0; }
                      cubit.setPlaybackSpeed(nextSpeed);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${state.playbackSpeed}x',
                        style: TextSTyle.f12CairoSemiBoldPrimary.copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),

                  // Main Controls
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ControlButton(
                        icon: Icons.skip_next_rounded, // Arabic (RTL) so skip next is actually going to previous ayah numerically visually
                        onTap: () => context.read<AudioPlayerCubit>().playPrevious(),
                        size: 32.sp,
                      ),
                      horizontalSpace(16),
                      GestureDetector(
                        onTap: () => context.read<AudioPlayerCubit>().playPauseAyah(),
                        child: Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.primary,
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.primary.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: state.isLoading
                              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                              : Icon(
                                  state.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 28.sp,
                                ),
                        ),
                      ),
                      horizontalSpace(16),
                      _ControlButton(
                        icon: Icons.skip_previous_rounded,
                        onTap: () => context.read<AudioPlayerCubit>().playNext(),
                        size: 32.sp,
                      ),
                    ],
                  ),

                  // Repeat Mode
                  GestureDetector(
                    onTap: () => context.read<AudioPlayerCubit>().toggleRepeatMode(),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: state.repeatMode != RepeatMode.off
                            ? ColorManager.primary.withValues(alpha: 0.1)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        state.repeatMode == RepeatMode.repeatAyah
                            ? Icons.repeat_one_rounded
                            : Icons.repeat_rounded,
                        color: state.repeatMode != RepeatMode.off
                            ? ColorManager.primary
                            : ColorManager.gray,
                        size: 22.sp,
                      ),
                    ),
                  ),
                ],
              ),

              verticalSpace(12),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: ColorManager.primary.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(ColorManager.primary),
                  minHeight: 4.h,
                ),
              ),
              verticalSpace(4),

              // Ayah indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${state.currentAyahIndex + 1} / $totalAyahs',
                    style: TextSTyle.f10CairoRegPrimary.copyWith(
                      color: ColorManager.gray,
                    ),
                  ),
                  if (state.errorMessage != null) ...[
                    Text(
                      state.errorMessage!,
                      style: TextSTyle.f10CairoRegPrimary.copyWith(
                        color: ColorManager.error,
                      ),
                    ),
                  ] else if (state.isLoading) ...[
                    Text(
                      'downloading'.tr(),
                      style: TextSTyle.f10CairoRegPrimary.copyWith(
                        color: ColorManager.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const _ControlButton({
    required this.icon,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : ColorManager.textHigh,
        size: size,
      ),
    );
  }
}
