import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:al_huda/feature/azkar/presentation/screens/azkar_detail_screen.dart';
import 'package:al_huda/feature/azkar/presentation/screens/azkar_screen.dart';
import 'package:al_huda/feature/home/presentation/screens/explore_screen.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_prayer_category_list.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_top_container.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/prayer_tracker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: isDark
            ? ColorManager.backgroundDark
            : ColorManager.background,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // ── Hero header ───────────────────────────────────────────
            const SliverToBoxAdapter(child: HomTopContainer()),

            // ── Body ──────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Section: Quick Access ─────────────────────────
                    _StaggeredItem(
                      index: 0,
                      child: _SectionLabel(
                        label: 'all_features'.tr(),
                        showSeeAll: true,
                        onSeeAll: () {
                          push(const ExploreScreen());
                        },
                      ),
                    ),
                    verticalSpace(16),
                    _StaggeredItem(
                      index: 1,
                      child: const HomePrayerCategoryLIst(),
                    ),

                    verticalSpace(32),

                    // ── Section: Azkar ────────────────────────────────
                    _StaggeredItem(
                      index: 2,
                      child: _SectionLabel(
                        label: 'azkar'.tr(),
                        showSeeAll: true,
                        onSeeAll: () => push(const AzkarScreen()),
                      ),
                    ),
                    verticalSpace(16),
                    BlocBuilder<AzkarCubit, AzkarState>(
                      builder: (context, state) {
                        final azkarCategories =
                            context.read<AzkarCubit>().azkarCategories;

                        return Row(
                          children: [
                            Expanded(
                              child: _StaggeredItem(
                                index: 3,
                                child: _AzkarCard(
                                  title: 'morning_azkar'.tr(),
                                  icon: AppIcons.sun,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF1B6B5A),
                                      Color(0xFF2DA882)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  onTap: () {
                                    if (azkarCategories.isNotEmpty) {
                                      push(
                                        AzkarDetailScreen(
                                          zikr: azkarCategories[0].azkar,
                                          zikrName: azkarCategories[0].name,
                                          index: 0,
                                        ),
                                      );
                                    } else {
                                      push(const AzkarScreen());
                                    }
                                  },
                                ),
                              ),
                            ),
                            horizontalSpace(12),
                            Expanded(
                              child: _StaggeredItem(
                                index: 4,
                                child: _AzkarCard(
                                  title: 'evening_azkar'.tr(),
                                  icon: AppIcons.masaa,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF0F1F1A),
                                      Color(0xFF1B6B5A)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  onTap: () {
                                    if (azkarCategories.length > 1) {
                                      push(
                                        AzkarDetailScreen(
                                          zikr: azkarCategories[1].azkar,
                                          zikrName: azkarCategories[1].name,
                                          index: 1,
                                        ),
                                      );
                                    } else {
                                      push(const AzkarScreen());
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    verticalSpace(32),

                    // ── Section: Prayer Tracker ───────────────────────
                    _StaggeredItem(
                      index: 5,
                      child: _SectionLabel(label: 'prayer_tracking'.tr()),
                    ),
                    verticalSpace(16),
                  ],
                ),
              ),
            ),

            // ── Prayer tracker ────────────────────────────────────────
            SliverToBoxAdapter(
              child: _StaggeredItem(
                index: 6,
                child: const PrayerTraker(),
              ),
            ),
            SliverToBoxAdapter(child: verticalSpace(40)),
          ],
        ),
      ),
    );
  }
}

// ─── Modular Section Label ───────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  final bool showSeeAll;
  final VoidCallback? onSeeAll;

  const _SectionLabel({
    required this.label,
    this.showSeeAll = false,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            horizontalSpace(12),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'SSTArabicMedium', // Switched from CairoBold
                fontSize: 17.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.9)
                    : ColorManager.textHigh,
              ),
            ),
          ],
        ),
        if (showSeeAll)
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'see_all'.tr(),
              style: TextStyle(
                fontFamily: 'SSTArabicMedium', // Switched from CairoSemiBold
                fontSize: 12.sp,
                color: ColorManager.primary,
              ),
            ),
          ),
      ],
    );
  }
}

// ─── Scenic Azkar Card (Standardized V5 Harmony) ───────────────────────────

class _AzkarCard extends StatelessWidget {
  final String title;
  final String icon;
  final LinearGradient gradient;
  final VoidCallback onTap;

  const _AzkarCard({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 104.h,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withValues(
                alpha: isDark ? 0.15 : 0.1,
              ),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Opacity(
                opacity: 0.08,
                child: SvgIcon(
                  assetName: icon,
                  width: 100.w,
                  height: 100.w,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 38.w,
                    height: 38.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.0,
                      ),
                    ),
                    child: Center(
                      child: SvgIcon(
                        assetName: icon,
                        width: 20.w,
                        height: 20.h,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'SSTArabicMedium', // Switched from CairoBold
                      fontSize: 14.sp,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
