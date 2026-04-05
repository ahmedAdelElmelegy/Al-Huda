import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/services/explore_history_service.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/home/presentation/screens/explore_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreSearchDelegate extends SearchDelegate<String> {
  final List<ExploreItem> allItems;

  ExploreSearchDelegate({required this.allItems});

  @override
  String get searchFieldLabel => 'search_explore'.tr();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? ColorManager.backgroundDark : ColorManager.background,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : ColorManager.textHigh,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontFamily: 'SSTArabicRoman',
          fontSize: 16.sp,
          color: isDark ? Colors.white54 : ColorManager.textLight,
        ),
        border: InputBorder.none,
      ),
      textTheme: theme.textTheme.copyWith(
        titleLarge: TextStyle(
          fontFamily: 'SSTArabicMedium',
          fontSize: 18.sp,
          color: isDark ? Colors.white : ColorManager.textHigh,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear_rounded),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final results = allItems.where((item) {
      final label = item.labelKey.tr().toLowerCase();
      final searchQuery = query.toLowerCase();
      return label.contains(searchQuery);
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64.sp,
              color: isDark ? Colors.white24 : ColorManager.textLight.withValues(alpha: 0.5),
            ),
            SizedBox(height: 16.h),
            Text(
              'no_items_found'.tr(),
              style: TextStyle(
                fontFamily: 'SSTArabicMedium',
                fontSize: 16.sp,
                color: isDark ? Colors.white54 : ColorManager.textMedium,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: InkWell(
            onTap: () {
              ExploreHistoryService.recordVisit(item.labelKey);
              close(context, '');
              push(item.screen);
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark ? ColorManager.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isDark ? Colors.white10 : ColorManager.primary.withValues(alpha: 0.05),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: item.color.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.icon,
                      color: item.color,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      item.labelKey.tr(),
                      style: TextStyle(
                        fontFamily: 'SSTArabicMedium',
                        fontSize: 16.sp,
                        color: isDark ? Colors.white : ColorManager.textHigh,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14.sp,
                    color: ColorManager.textLight,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
