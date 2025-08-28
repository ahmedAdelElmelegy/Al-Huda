import 'package:al_huda/core/data/api_url/app_url.dart';
import 'package:al_huda/core/helper/spacing.dart';
import 'package:al_huda/feature/home/presentation/widgets/all_prayers_headline.dart';

import 'package:al_huda/feature/home/presentation/widgets/home_date_and_location.dart';
import 'package:al_huda/feature/home/presentation/widgets/home_prayer_banner.dart';
import 'package:al_huda/feature/home/presentation/widgets/home_prayer_time_listview.dart';
import 'package:al_huda/feature/home/presentation/widgets/prayers_list.dart';
import 'package:al_huda/feature/prayer_time/presentation/manager/cubit/prayer_time_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PrayerTimeCubit>().getPrayerTime(
      AppURL.latitude,
      AppURL.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<PrayerTimeCubit, PrayerTimeState>(
            builder: (context, state) {
              final cubit = context.read<PrayerTimeCubit>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(18),
                  HomeDateAndLocation(
                    location: cubit.prayerTimeModel?.data?.meta?.timezone,
                  ),
                  verticalSpace(16),
                  HomePrayerTimeListView(),
                  verticalSpace(16),
                  HomePrayerBanner(),
                  verticalSpace(18),
                  AllPrayersHeadline(),
                  verticalSpace(16),

                  PrayersList(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
