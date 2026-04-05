import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/home/presentation/screens/home_screen.dart';
import 'package:al_huda/feature/home/presentation/screens/explore_screen.dart';
import 'package:al_huda/feature/qran/presentation/screens/qran_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/settings_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomeScreen(),
    QranScreen(),
    ExploreScreen(),
    SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? ColorManager.surfaceDark : Colors.white,
          boxShadow: [
            BoxShadow(
              color: ColorManager.primary.withValues(alpha: isDark ? 0.2 : 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
          border: Border(
            top: BorderSide(
              color: ColorManager.primary.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 72.h, // Increased for a more premium, spacious feel
            child: Row(
              children: [
                _NavItem(
                  index: 0,
                  selected: _selectedIndex,
                  icon: Icons.home_rounded,
                  label: 'tab_home'.tr(),
                  onTap: _onTabTapped,
                ),
                _NavItem(
                  index: 1,
                  selected: _selectedIndex,
                  icon: Icons.menu_book_rounded,
                  label: 'tab_quran'.tr(),
                  onTap: _onTabTapped,
                ),
                _NavItem(
                  index: 2,
                  selected: _selectedIndex,
                  icon: Icons.apps_rounded,
                  label: 'tab_explore'.tr(),
                  onTap: _onTabTapped,
                ),
                _NavItem(
                  index: 3,
                  selected: _selectedIndex,
                  icon: Icons.settings_rounded,
                  label: 'tab_settings'.tr(),
                  onTap: _onTabTapped,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int selected;
  final IconData icon;
  final String label;
  final void Function(int) onTap;

  const _NavItem({
    required this.index,
    required this.selected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selected;
    final color = isSelected ? ColorManager.primary : ColorManager.textLight;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated indicator pill behind the icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: isSelected ? 48.w : 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorManager.primary.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24.sp, // Slightly larger
              ),
            ),
            SizedBox(height: 4.h),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontFamily: isSelected ? 'SSTArabicMedium' : 'SSTArabicRoman',
                fontSize: 11.sp,
                color: color,
                height: 1.0,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
