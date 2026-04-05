import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/qran/presentation/screens/qran_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePrayerCategoryLIst extends StatelessWidget {
  const HomePrayerCategoryLIst({super.key});

  static final List<_QuickItem> _quickItems = [
    _QuickItem(
      labelKey: 'quran',
      icon: AppIcons.qran,
      screen: const QranScreen(),
    ),
    _QuickItem(
      labelKey: 'azkar',
      icon: AppIcons.azkar,
      screen: Constants.homePrayerCategory
          .firstWhere((e) => e.name == 'azkar')
          .screen!,
    ),
    _QuickItem(
      labelKey: 'tasbeh',
      icon: AppIcons.tasbih,
      screen: Constants.homePrayerCategory
          .firstWhere((e) => e.name == 'tasbeh')
          .screen!,
    ),
    _QuickItem(
      labelKey: 'nearest_mosque',
      icon: AppIcons.mosque,
      screen: Constants.homePrayerCategory
          .firstWhere((e) => e.name == 'nearest_mosque')
          .screen!,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: isDark ? ColorManager.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withValues(alpha: isDark ? 0.12 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : ColorManager.primary.withValues(alpha: 0.08),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_quickItems.length, (index) {
          return _StaggeredItem(
            index: index,
            child: _QuickGridItem(item: _quickItems[index]),
          );
        }),
      ),
    );
  }
}

class _QuickItem {
  final String labelKey;
  final String icon;
  final Widget screen;
  const _QuickItem({
    required this.labelKey,
    required this.icon,
    required this.screen,
  });
}

class _QuickGridItem extends StatelessWidget {
  final _QuickItem item;
  const _QuickGridItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => push(item.screen),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 62.w,
            height: 62.w,
            decoration: BoxDecoration(
              color: isDark 
                  ? Colors.white.withValues(alpha: 0.03) 
                  : ColorManager.primary.withValues(alpha: 0.04),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorManager.primary.withValues(alpha: 0.15),
                      ColorManager.primary.withValues(alpha: 0.02),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.primary.withValues(alpha: 0.2),
                    width: 1.2,
                  ),
                ),
                child: Center(
                  child: SvgIcon(
                    assetName: item.icon,
                    width: 24.w,
                    height: 24.h,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
          ),
          verticalSpace(10),
          Text(
            item.labelKey.tr(),
            style: TextStyle(
              fontFamily: 'SSTArabicMedium', // Switched from CairoBold
              fontSize: 11.sp,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.8)
                  : ColorManager.textHigh,
              letterSpacing: 0.2, // Increased for SST
            ),
          ),
        ],
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
