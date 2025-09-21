import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNextPrayer extends StatefulWidget {
  const HomeNextPrayer({super.key});

  @override
  State<HomeNextPrayer> createState() => _HomeNextPrayerState();
}

class _HomeNextPrayerState extends State<HomeNextPrayer> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PrayerCubit>();
    return Row(
      children: [
        Text(
          'الصلاة القادمة :  ${cubit.getCurrentPrayer().tr()}',
          style: TextSTyle.f16AmiriBoldPrimary.copyWith(
            color: ColorManager.white,
          ),
        ),
      ],
    );
  }
}
