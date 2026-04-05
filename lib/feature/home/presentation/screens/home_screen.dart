import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_prayer_category_list.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/home_top_container.dart';
import 'package:al_huda/feature/home/presentation/screens/widget/prayer_tracker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: HomTopContainer()),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  ),
                ),
                child: Column(
                  children: [
                    verticalSpace(24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: HomePrayerCategoryLIst(),
                    ),
                    verticalSpace(24),
                    const PrayerTraker(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
