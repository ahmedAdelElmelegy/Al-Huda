import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/tasbeh_services.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void init() {
  // services
  getIt.registerLazySingleton<TasbehServices>(() => TasbehServices());

  getIt.registerLazySingleton<PrayerServices>(() => PrayerServices());

  // cubits
  getIt.registerLazySingleton<TasbehCubit>(
    () => TasbehCubit(getIt<TasbehServices>()),
  );

  getIt.registerLazySingleton<PrayerCubit>(
    () => PrayerCubit(getIt<PrayerServices>()),
  );
}
