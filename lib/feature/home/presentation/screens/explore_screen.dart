import 'package:al_huda/core/helper/extentions.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/services/explore_history_service.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/allah_name/presentation/screens/allah_name_screen.dart';
import 'package:al_huda/feature/family/presentation/screens/family_screen.dart';
import 'package:al_huda/feature/hajj/presentation/screens/hajj_umrah_screen.dart';
import 'package:al_huda/feature/hifz/presentation/screens/hifz_dashboard_screen.dart';
import 'package:al_huda/feature/library/presentation/screens/library_screen.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/screens/nearest_mosque_screen.dart';
import 'package:al_huda/feature/pharmacy/presentation/screens/pharmacy_screen.dart';
import 'package:al_huda/feature/quiz/presentation/screens/quiz_screen.dart';
import 'package:al_huda/feature/radio/presentation/screens/radio_screen.dart';
import 'package:al_huda/feature/ramadan/presentation/screens/khatma_screen.dart';
import 'package:al_huda/feature/ramadan/presentation/screens/ramadan_screen.dart';
import 'package:al_huda/feature/sunnah/presentation/screens/hadith_books_screen.dart';
import 'package:al_huda/feature/sunnah/presentation/screens/sunnah_habits_screen.dart';

import 'package:al_huda/feature/doaa/presentation/screens/doaa_screen.dart';
import 'package:al_huda/feature/calender/presentation/screens/calender_screen.dart';
import 'package:al_huda/feature/favorite/presentation/screens/favorite_screen.dart';
import 'package:al_huda/feature/tasbeh/presentation/screens/tasbeh_screen.dart';

import 'package:al_huda/feature/home/presentation/screens/widget/explore_doaa_banner.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/explore_grid_item.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/explore_recent_section.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/explore_search_delegate.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Data Model ──────────────────────────────────────────────────────────────

class ExploreItem {
  final String labelKey;
  final IconData icon;
  final Widget screen;
  final Color color;

  const ExploreItem({
    required this.labelKey,
    required this.icon,
    required this.screen,
    required this.color,
  });
}

class ExploreSection {
  final String titleKey;
  final List<ExploreItem> items;
  final Color sectionColor;

  const ExploreSection({
    required this.titleKey,
    required this.items,
    required this.sectionColor,
  });
}

// ─── Screen ───────────────────────────────────────────────────────────────────

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool isGridMode = false;

  static final List<ExploreSection> _sections = [
    ExploreSection(
      titleKey: 'section_learning',
      sectionColor: ColorManager.primary,
      items: [
        ExploreItem(
          labelKey: 'hadith_books_title',
          icon: Icons.import_contacts_rounded,
          screen: const HadithBooksScreen(),
          color: ColorManager.primary,
        ),
        ExploreItem(
          labelKey: 'library',
          icon: Icons.local_library_rounded,
          screen: const LibraryScreen(),
          color: ColorManager.primary,
        ),
        ExploreItem(
          labelKey: 'sunnah_habits',
          icon: Icons.volunteer_activism_rounded,
          screen: const SunnahHabitsScreen(),
          color: ColorManager.primary,
        ),
        ExploreItem(
          labelKey: 'quiz',
          icon: Icons.quiz_rounded,
          screen: const QuizScreen(),
          color: ColorManager.primary,
        ),
        ExploreItem(
          labelKey: 'hifz_tracker',
          icon: Icons.bookmark_added_rounded,
          screen: const HifzDashboardScreen(),
          color: ColorManager.primary,
        ),
      ],
    ),
    ExploreSection(
      titleKey: 'section_services',
      sectionColor: Colors.blue.shade600,
      items: [
        ExploreItem(
          labelKey: 'hajj_umrah_guide',
          icon: Icons.cabin_rounded,
          screen: const HajjUmrahScreen(),
          color: Colors.blue.shade600,
        ),
        ExploreItem(
          labelKey: 'nearest_mosque',
          icon: Icons.mosque_rounded,
          screen: NearestMosqueScreen(),
          color: Colors.blue.shade600,
        ),
        ExploreItem(
          labelKey: 'pharmacy',
          icon: Icons.local_pharmacy_rounded,
          screen: const PharmacyScreen(),
          color: Colors.blue.shade600,
        ),
        ExploreItem(
          labelKey: 'calender',
          icon: Icons.calendar_month_rounded,
          screen: const CalenderScreen(),
          color: Colors.blue.shade600,
        ),
        ExploreItem(
          labelKey: 'doaa',
          icon: Icons.pan_tool_rounded,
          screen: const DoaaScreen(),
          color: Colors.blue.shade600,
        ),
      ],
    ),
    ExploreSection(
      titleKey: 'section_community',
      sectionColor: Colors.purple.shade500,
      items: [
        ExploreItem(
          labelKey: 'global_khatma',
          icon: Icons.public_rounded,
          screen: const KhatmaScreen(),
          color: Colors.purple.shade500,
        ),
        ExploreItem(
          labelKey: 'family_mode',
          icon: Icons.family_restroom_rounded,
          screen: const FamilyScreen(),
          color: Colors.purple.shade500,
        ),
        ExploreItem(
          labelKey: 'ramadan_portal',
          icon: Icons.nights_stay_rounded,
          screen: const RamadanScreen(),
          color: Colors.purple.shade500,
        ),
      ],
    ),
    ExploreSection(
      titleKey: 'section_spiritual',
      sectionColor: ColorManager.gold,
      items: [
        ExploreItem(
          labelKey: 'allah_name',
          icon: Icons.auto_awesome_rounded,
          screen: AllahNameScreen(),
          color: ColorManager.gold,
        ),
        ExploreItem(
          labelKey: 'radio',
          icon: Icons.radio_rounded,
          screen: RadioScreen(),
          color: ColorManager.gold,
        ),
        ExploreItem(
          labelKey: 'favorite',
          icon: Icons.favorite_rounded,
          screen: const FavoriteScreen(),
          color: ColorManager.gold,
        ),
        ExploreItem(
          labelKey: 'tasbeh',
          icon: Icons.fingerprint_rounded,
          screen: TasbehScreen(),
          color: ColorManager.gold,
        ),
      ],
    ),
  ];

  // Helper to get all items flattened for Search and Recent
  List<ExploreItem> get _allItems {
    return _sections.expand((section) => section.items).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isGridMode = prefs.getBool('explore_grid_mode') ?? false;
    });
  }

  Future<void> _toggleGridMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isGridMode = !isGridMode;
      prefs.setBool('explore_grid_mode', isGridMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? ColorManager.backgroundDark
          : ColorManager.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const ExploreDoaaBanner(),
                verticalSpace(24),

                ExploreRecentSection(allItems: _allItems),
                verticalSpace(8),

                ..._sections.asMap().entries.map((entry) {
                  final index = entry.key;
                  final section = entry.value;

                  return _StaggeredItem(
                    index: index,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SectionHeader(
                            titleKey: section.titleKey,
                            color: section.sectionColor,
                          ),
                          verticalSpace(16),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: isGridMode
                                ? _SectionGrid(
                                    key: const ValueKey('grid'),
                                    items: section.items,
                                    isDark: isDark,
                                  )
                                : _SectionCard(
                                    key: const ValueKey('list'),
                                    items: section.items,
                                    isDark: isDark,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 140.h,
      backgroundColor: ColorManager.primary,
      elevation: 4,
      shadowColor: ColorManager.primary.withValues(alpha: 0.2),
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: 16.h),
        title: Text(
          'tab_explore'.tr(),
          style: TextStyle(
            fontFamily: 'SSTArabicMedium',
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorManager.primary, ColorManager.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: -30,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(
                    Icons.explore_rounded,
                    size: 150.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: ExploreSearchDelegate(allItems: _allItems),
            );
          },
          icon: Icon(Icons.search_rounded, color: Colors.white, size: 24.sp),
          tooltip: 'search_explore'.tr(),
        ),
        IconButton(
          onPressed: _toggleGridMode,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(
              turns: child.key == const ValueKey('icon1')
                  ? Tween<double>(begin: 1, end: 0.5).animate(anim)
                  : Tween<double>(begin: 0.5, end: 1).animate(anim),
              child: FadeTransition(opacity: anim, child: child),
            ),
            child: Icon(
              isGridMode ? Icons.view_list_rounded : Icons.grid_view_rounded,
              key: ValueKey(isGridMode ? 'icon1' : 'icon2'),
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          tooltip: isGridMode ? 'view_list'.tr() : 'view_grid'.tr(),
        ),
        horizontalSpace(8),
      ],
    );
  }
}

// ─── Section Header ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String titleKey;
  final Color color;
  const _SectionHeader({required this.titleKey, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        horizontalSpace(12),
        Text(
          titleKey.tr(),
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
    );
  }
}

// ─── Section Grid ─────────────────────────────────────────────────────────────

class _SectionGrid extends StatelessWidget {
  final List<ExploreItem> items;
  final bool isDark;

  const _SectionGrid({super.key, required this.items, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _StaggeredItem(
          index: index,
          child: ExploreGridItemCard(item: items[index]),
        );
      },
    );
  }
}

// ─── Section Card (List) ───────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final List<ExploreItem> items;
  final bool isDark;

  const _SectionCard({super.key, required this.items, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _StaggeredItem(
              index: i,
              child: _ExploreRow(
                item: items[i],
                isFirst: i == 0,
                isLast: i == items.length - 1,
              ),
            ),
            if (i < items.length - 1)
              Divider(
                height: 1,
                indent: 72.w,
                endIndent: 16.w,
                color: ColorManager.primary.withValues(alpha: 0.06),
              ),
          ],
        ],
      ),
    );
  }
}

// ─── Explore Row ──────────────────────────────────────────────────────────────

class _ExploreRow extends StatelessWidget {
  final ExploreItem item;
  final bool isFirst;
  final bool isLast;

  const _ExploreRow({
    required this.item,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        ExploreHistoryService.recordVisit(item.labelKey);
        push(item.screen);
      },
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(isFirst ? 32.r : 0),
        bottom: Radius.circular(isLast ? 32.r : 0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            // Glassmorphic Icon Hub
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    item.color.withValues(alpha: 0.12),
                    item.color.withValues(alpha: 0.04),
                  ],
                ),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: item.color.withValues(alpha: 0.15),
                  width: 1.2,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: item.color.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Icon(item.icon, color: item.color, size: 22.sp),
                ],
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: Text(
                item.labelKey.tr(),
                style: TextStyle(
                  fontFamily: 'SSTArabicRoman',
                  fontSize: 16.sp,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.9)
                      : ColorManager.textHigh,
                  height: 1.2,
                ),
              ),
            ),
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 14.sp,
              color: ColorManager.primary.withValues(alpha: 0.4),
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
      duration: Duration(
        milliseconds: 400 + (index * 50),
      ), // slightly faster so it doesn't take forever with many items
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 15 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
