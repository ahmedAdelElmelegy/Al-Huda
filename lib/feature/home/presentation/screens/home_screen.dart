import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/feature/home/presentation/widgets/all_prayers_headline.dart';

import 'package:al_huda/feature/home/presentation/widgets/home_date_and_location.dart';
import 'package:al_huda/feature/home/presentation/widgets/home_prayer_banner.dart';
import 'package:al_huda/feature/home/presentation/widgets/home_prayer_time_listview.dart';
import 'package:al_huda/feature/home/presentation/widgets/prayers_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(18),
              HomeDateAndLocation(),
              verticalSpace(16),
              HomePrayerTimeListView(),
              verticalSpace(16),
              HomePrayerBanner(),
              verticalSpace(18),
              AllPrayersHeadline(),
              verticalSpace(16),

              PrayersList(),
            ],
          ),
        ),
      ),
    );
  }
}
