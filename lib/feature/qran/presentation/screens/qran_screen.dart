import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/qran/presentation/screens/tabs/bookmarks_tab.dart';
import 'package:al_huda/feature/qran/presentation/screens/tabs/juz_list_tab.dart';
import 'package:al_huda/feature/qran/presentation/screens/tabs/surah_list_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QranScreen extends StatelessWidget {
  const QranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: isDark
            ? ColorManager.backgroundDark
            : ColorManager.background,
        appBar: AppBar(
          title: Text(
            'quran'.tr(),
            style: TextStyle(
              fontFamily: 'SSTArabicMedium',
              fontSize: 20.sp,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: ColorManager.primary,
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
            labelStyle: TextStyle(
              fontFamily: 'SSTArabicMedium',
              fontSize: 16.sp,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'SSTArabicRoman',
              fontSize: 14.sp,
            ),
            tabs: [
              Tab(text: 'surah'.tr()),
              Tab(text: 'juz'.tr()),
              Tab(text: 'bookmarks'.tr()),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
        ),
        body: const TabBarView(
          children: [
            SurahListTab(),
            JuzListTab(),
            BookmarksTab(),
          ],
        ),
      ),
    );
  }
}
