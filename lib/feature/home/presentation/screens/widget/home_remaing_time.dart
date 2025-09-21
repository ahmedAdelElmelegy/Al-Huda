import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/core/theme/style.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeRemaingTime extends StatelessWidget {
  const HomeRemaingTime({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PrayerCubit>();
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        return StreamBuilder<int>(
          stream: Stream.periodic(const Duration(seconds: 1), (x) => x),
          builder: (context, snapshot) {
            return Text(
              PrayerServices.getRemainingTime(cubit),
              style: TextSTyle.f24SSTArabicMediumPrimary.copyWith(
                color: ColorManager.white,
              ),
            );
          },
        );
      },
    );
  }
}
