import 'dart:ui';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_location.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomTopContainer extends StatelessWidget {
  const HomTopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(44),
          bottomRight: Radius.circular(44),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: 0.35),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ── Background Image ─────────────────────────────────────────────
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(44),
                bottomRight: Radius.circular(44),
              ),
              child: Image.asset(AppImages.home, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(44),
                  bottomRight: Radius.circular(44),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorManager.primary.withValues(alpha: 0.85),
                    ColorManager.primary.withValues(alpha: 0.4),
                    ColorManager.primary.withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
              child: Column(
                children: [
                  _StaggeredItem(
                    index: 0,
                    child: _FloatingHeaderPill(),
                  ),
                  verticalSpace(36),
                  _StaggeredItem(
                    index: 1,
                    child: const _CircularPrayerHub(),
                  ),
                  verticalSpace(42),
                  _StaggeredItem(
                    index: 2,
                    child: const _ZenPillarsPrayerBar(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Floating Header Pill ────────────────────────────────────────────────────

class _FloatingHeaderPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CompactDate(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Container(
                  width: 1,
                  height: 12.h,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),
              const HomeLocation(compact: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgIcon(
          assetName: AppIcons.calender2,
          width: 13.w,
          height: 13.h,
          color: ColorManager.accent,
        ),
        horizontalSpace(8),
        Text(
          PrayerServices.getFormattedGregorianDate(DateTime.now(), context),
          style: TextStyle(
            fontFamily: 'SSTArabicMedium', // Switched from CairoBold
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

// ─── Circular Prayer Hub (Modified to Remove Shurooq) ───────────────────────

class _CircularPrayerHub extends StatelessWidget {
  const _CircularPrayerHub();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        final cubit = context.read<PrayerCubit>();
        String prayerName = cubit.getCurrentPrayer();

        if (prayerName == 'shurooq') {
          prayerName = 'dhuhr';
        }

        double progress = 0.65;
        try {
          final now = DateTime.now();
          final validTimes =
              cubit.prayerTimes.where((p) => p.key != 'shurooq').toList();

          int currentIndex = 0;
          for (int i = 0; i < validTimes.length; i++) {
            if (now.isAfter(validTimes[i].value)) currentIndex = i;
          }

          if (currentIndex < validTimes.length - 1) {
            final start = validTimes[currentIndex].value;
            final end = validTimes[currentIndex + 1].value;
            progress =
                (now.difference(start).inSeconds /
                        end.difference(start).inSeconds)
                    .clamp(0.0, 1.0);
          } else if (now.isAfter(validTimes.last.value)) {
            progress = 1.0;
          }
        } catch (_) {}

        return Stack(
          alignment: Alignment.center,
          children: [
            ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: 200.w,
                  height: 200.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 186.w,
              height: 186.w,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 2,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            SizedBox(
              width: 186.w,
              height: 186.w,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                color: ColorManager.accent,
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              children: [
                Text(
                  prayerName.tr(),
                  style: TextStyle(
                    fontFamily: 'AmiriBold', // Keep Amiri for spiritual names
                    fontSize: 24.sp,
                    color: ColorManager.accent,
                    height: 1.0,
                  ),
                ),
                verticalSpace(4),
                StreamBuilder<int>(
                  stream: Stream.periodic(const Duration(seconds: 1), (x) => x),
                  builder: (context, snapshot) {
                    String remaining = PrayerServices.getRemainingTime(cubit);
                    if (cubit.getCurrentPrayer() == 'shurooq') {
                      try {
                        final dhuhr = cubit.prayerTimes
                            .firstWhere((p) => p.key == 'dhuhr')
                            .value;
                        final diff = dhuhr.difference(DateTime.now());
                        if (diff.isNegative) {
                          remaining = "00:00:00";
                        } else {
                          final h = diff.inHours.toString().padLeft(2, '0');
                          final m =
                              (diff.inMinutes % 60).toString().padLeft(2, '0');
                          final s =
                              (diff.inSeconds % 60).toString().padLeft(2, '0');
                          remaining = "$h:$m:$s";
                        }
                      } catch (_) {}
                    }
                    return Text(
                      remaining,
                      style: TextStyle(
                        fontFamily: 'SSTArabicMedium', // Switched from CairoBold
                        fontSize: 36.sp, // Slightly reduced for SST width
                        color: Colors.white,
                        letterSpacing: 1.5,
                        height: 1.0,
                      ),
                    );
                  },
                ),
                Text(
                  'remaining_time'.tr(),
                  style: TextStyle(
                    fontFamily: 'SSTArabicRoman', // Switched from CairoRegular
                    fontSize: 10.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// ─── Zen Pillars Prayer Bar (Modified to Remove Shurooq) ────────────────────

class _ZenPillarsPrayerBar extends StatelessWidget {
  const _ZenPillarsPrayerBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        final cubit = context.read<PrayerCubit>();
        if (state is PrayerLoading) return const SizedBox.shrink();

        final filteredPrayers =
            Constants.prayer.where((p) => p.name != 'shurooq').toList();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(filteredPrayers.length, (index) {
              final prayer = filteredPrayers[index];
              final isActive = prayer.name == cubit.getCurrentPrayer();

              final originalIndex =
                  Constants.prayer.indexWhere((p) => p.name == prayer.name);
              final timeStr = DateFormat('hh:mm')
                  .format(cubit.prayerTimes[originalIndex].value);

              return _ZenPrayerPillar(
                name: prayer.name,
                time: timeStr,
                isActive: isActive,
                icon: _getIcon(prayer.name),
              );
            }),
          ),
        );
      },
    );
  }

  String _getIcon(String name) {
    switch (name.toLowerCase()) {
      case 'fajr':
        return AppIcons.fagr;
      case 'sunrise':
        return AppIcons.shroq;
      case 'dhuhr':
        return AppIcons.sun;
      case 'asr':
        return AppIcons.sun2;
      case 'maghrib':
        return AppIcons.magrib;
      case 'isha':
        return AppIcons.moon;
      default:
        return AppIcons.clock;
    }
  }
}

class _ZenPrayerPillar extends StatelessWidget {
  final String name;
  final String time;
  final bool isActive;
  final String icon;

  const _ZenPrayerPillar({
    required this.name,
    required this.time,
    required this.isActive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedScale(
          duration: const Duration(milliseconds: 400),
          scale: isActive ? 1.15 : 1.0,
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive
                        ? ColorManager.accent
                        : Colors.white.withValues(alpha: 0.15),
                    width: isActive ? 1.5 : 0.8,
                  ),
                ),
                child: Center(
                  child: SvgIcon(
                    assetName: icon,
                    width: 20.w,
                    height: 20.h,
                    color: isActive ? ColorManager.primary : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        verticalSpace(10),
        Text(
          time,
          style: TextStyle(
            fontFamily: 'SSTArabicMedium', // Switched from CairoBold
            fontSize: 12.sp, // Adjusted for SST height
            color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.7),
          ),
        ),
        verticalSpace(2),
        Text(
          name.tr(),
          style: TextStyle(
            fontFamily: 'SSTArabicRoman', // Switched from CairoRegular
            fontSize: 10.sp,
            color: isActive
                ? ColorManager.accent
                : Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}

class _StaggeredItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _StaggeredItem({required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + (index * 80)),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
