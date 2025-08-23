import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
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
      ],
      child: child,
    );
  }
}
