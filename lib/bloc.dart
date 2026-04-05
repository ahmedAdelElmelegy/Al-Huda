import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/feature/allah_name/presentation/manager/cubit/allah_name_cubit.dart';
import 'package:al_huda/feature/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:al_huda/feature/doaa/presentation/manager/cubit/doaa_cubit.dart';
import 'package:al_huda/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/manager/cubit/google_map_cubit.dart';
import 'package:al_huda/feature/prayer_time/presentation/manager/cubit/prayer_time_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/ayat/ayat_cubit.dart';
import 'package:al_huda/feature/radio/presentation/manager/cubit/radio_cubit.dart';
import 'package:al_huda/feature/quiz/presentation/manager/quiz_cubit.dart';
import 'package:al_huda/feature/pharmacy/presentation/manager/pharmacy_cubit.dart';
import 'package:al_huda/feature/library/presentation/manager/library_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:al_huda/feature/hifz/presentation/manager/hifz_cubit.dart';
import 'package:al_huda/feature/ramadan/presentation/manager/ramadan_cubit.dart';
import 'package:al_huda/feature/family/presentation/manager/family_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/audio/audio_player_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/bookmark/bookmark_cubit.dart';
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

        BlocProvider(create: (context) => getIt<GoogleMapCubit>()),
        BlocProvider(create: (context) => getIt<DoaaCubit>()),
        BlocProvider(create: (context) => getIt<FavoriteCubit>()..getAllZikr()),
        BlocProvider(create: (context) => getIt<QuizCubit>()..loadQuiz()),
        BlocProvider(
          create: (context) => getIt<PharmacyCubit>()..loadPharmacy(),
        ),
        BlocProvider(create: (context) => getIt<LibraryCubit>()),
        BlocProvider(create: (context) => getIt<HifzCubit>()),
        BlocProvider(create: (context) => getIt<RamadanCubit>()),
        BlocProvider(create: (context) => getIt<FamilyCubit>()..getMembers()),
        BlocProvider(create: (context) => getIt<AudioPlayerCubit>()),
        BlocProvider(create: (context) => getIt<BookmarkCubit>()..loadBookmarks()),
      ],


      child: child,
    );
  }
}
