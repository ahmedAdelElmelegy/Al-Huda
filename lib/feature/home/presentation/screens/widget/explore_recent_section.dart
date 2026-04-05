import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/explore_history_service.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/home/presentation/screens/explore_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreRecentSection extends StatefulWidget {
  final List<ExploreItem> allItems;

  const ExploreRecentSection({super.key, required this.allItems});

  @override
  State<ExploreRecentSection> createState() => _ExploreRecentSectionState();
}

class _ExploreRecentSectionState extends State<ExploreRecentSection> {
  List<ExploreItem> recentItems = [];

  @override
  void initState() {
    super.initState();
    _loadRecent();
  }

  void _loadRecent() {
    final recentKeys = ExploreHistoryService.getRecent(4);
    setState(() {
      recentItems = recentKeys.map((key) {
        return widget.allItems.firstWhere((item) => item.labelKey == key,
            orElse: () => widget.allItems.first); // fallback
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (recentItems.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 20.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.accent,
                    ColorManager.accent.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            horizontalSpace(12),
            Text(
              'recently_used'.tr(),
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 18.sp,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.95)
                    : ColorManager.textHigh,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        verticalSpace(16),
        SizedBox(
          height: 90.h,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: recentItems.length,
            separatorBuilder: (context, index) => horizontalSpace(16),
            itemBuilder: (context, index) {
              final item = recentItems[index];

              return GestureDetector(
                onTap: () {
                  ExploreHistoryService.recordVisit(item.labelKey);
                  push(item.screen);
                  _loadRecent(); // Refresh on return
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : item.color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: item.color.withValues(alpha: 0.2),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          item.icon,
                          color: item.color,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    verticalSpace(8),
                    SizedBox(
                      width: 72.w,
                      child: Text(
                        item.labelKey.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SSTArabicMedium',
                          fontSize: 11.sp,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.8)
                              : ColorManager.textMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
