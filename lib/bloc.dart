import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/feature/allah_name/presentation/manager/cubit/allah_name_cubit.dart';
import 'package:al_huda/feature/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/prayer_time/presentation/manager/cubit/prayer_time_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/ayat/ayat_cubit.dart';
import 'package:al_huda/feature/radio/presentation/manager/cubit/radio_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateMultiBloc extends StatelessWidget {
  const GenerateMultiBloc({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<TasbehCubit>()..getTasbeh()),
        BlocProvider(
          create: (context) => getIt<PrayerCubit>()..getPrayerTimes(),
        ),
        BlocProvider(create: (context) => getIt<AzkarCubit>()..loadAzkar()),
        BlocProvider(create: (context) => getIt<QranCubit>()..fetchSurah()),
        BlocProvider(create: (context) => getIt<AyatCubit>()),
        BlocProvider(create: (context) => getIt<RadioCubit>()..getRadio()),
        BlocProvider(
          create: (context) => getIt<AllahNameCubit>()..getAllahNames(),
        ),
        BlocProvider(create: (context) => getIt<PrayerTimeCubit>()),
      ],

      child: child,
    );
  }
}
