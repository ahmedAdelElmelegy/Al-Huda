import 'package:al_huda/core/helper/app_constants.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/widgets/svg_icon.dart';
import 'package:al_huda/feature/home/presentation/screens/home_screen.dart';
import 'package:al_huda/feature/qran/presentation/screens/qran_screen.dart';
import 'package:al_huda/feature/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    // PrayerTimeScreen(),
    QranScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withValues(alpha: .1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            height: 65.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildBottomNavigationBar(
                  color: _selectedIndex == 0
                      ? ColorManager.primary
                      : ColorManager.gray,
                  icon: _selectedIndex == 0
                      ? AppIcons.homActive
                      : AppIcons.home,
                  onTap: () => onItemTapped(0),
                ),
                // buildBottomNavigationBar(
                //   icon: _selectedIndex == 1 ? AppIcons.clockA : AppIcons.clock,
                //   onTap: () => onItemTapped(1),
                // ),
                buildBottomNavigationBar(
                  color: _selectedIndex == 1
                      ? ColorManager.primary
                      : ColorManager.gray,
                  icon: _selectedIndex == 1 ? AppIcons.qranA : AppIcons.qran,
                  onTap: () => onItemTapped(1),
                ),
                buildBottomNavigationBar(
                  color: _selectedIndex == 2
                      ? ColorManager.primary
                      : ColorManager.gray,
                  icon: _selectedIndex == 2
                      ? AppIcons.settingActive
                      : AppIcons.setttings,
                  onTap: () => onItemTapped(2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget buildBottomNavigationBar({
  required String icon,
  required Color color,
  required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: SvgIcon(assetName: icon, color: color),
  );
}
