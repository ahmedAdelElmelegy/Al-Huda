import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/explore_history_service.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/home/presentation/screens/explore_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreGridItemCard extends StatelessWidget {
  final ExploreItem item;

  const ExploreGridItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        ExploreHistoryService.recordVisit(item.labelKey);
        push(item.screen);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? ColorManager.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withValues(alpha: isDark ? 0.12 : 0.06),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : item.color.withValues(alpha: 0.1),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    item.color.withValues(alpha: 0.15),
                    item.color.withValues(alpha: 0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 24.sp,
                ),
              ),
            ),
            verticalSpace(12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                item.labelKey.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'SSTArabicMedium',
                  fontSize: 13.sp,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.9)
                      : ColorManager.textHigh,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
