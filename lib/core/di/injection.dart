import 'package:al_huda/core/services/api_services.dart';
import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/core/services/doaa_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/qran_services.dart';
import 'package:al_huda/core/services/tasbeh_services.dart';
import 'package:al_huda/feature/allah_name/data/repo/allah_name_repo.dart';
import 'package:al_huda/feature/allah_name/presentation/manager/cubit/allah_name_cubit.dart';
import 'package:al_huda/feature/azkar/data/repo/azkar_repo.dart';
import 'package:al_huda/feature/azkar/presentation/manager/cubit/azkar_cubit.dart';
import 'package:al_huda/feature/doaa/data/repo/doaa_repo.dart';
import 'package:al_huda/feature/doaa/presentation/manager/cubit/doaa_cubit.dart';
import 'package:al_huda/feature/favorite/presentation/manager/cubit/favorite_cubit.dart';
import 'package:al_huda/feature/home/presentation/manager/cubit/prayer_cubit.dart';
import 'package:al_huda/feature/nearst_mosque/presentation/manager/cubit/google_map_cubit.dart';
import 'package:al_huda/feature/prayer_time/data/repo/prayer_repo.dart';
import 'package:al_huda/feature/prayer_time/presentation/manager/cubit/prayer_time_cubit.dart';
import 'package:al_huda/feature/qran/data/Repo/ayat_repo.dart';
import 'package:al_huda/feature/qran/data/Repo/qran_repo.dart';
import 'package:al_huda/feature/qran/presentation/manager/Surah/qran_cubit.dart';
import 'package:al_huda/feature/qran/presentation/manager/ayat/ayat_cubit.dart';
import 'package:al_huda/feature/radio/data/repo/radio_repo.dart';
import 'package:al_huda/feature/radio/presentation/manager/cubit/radio_cubit.dart';
import 'package:al_huda/feature/tasbeh/presentation/manager/tasbeh/tasbeh_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:al_huda/core/utils/dio_factory.dart';

final getIt = GetIt.instance;
void init() async {
  // dio
  final dio = DioFactory.getDio();
  getIt.registerLazySingleton<Dio>(() => dio);
  // services
  getIt.registerLazySingleton<TasbehServices>(() => TasbehServices());

  getIt.registerLazySingleton<PrayerServices>(() => PrayerServices());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // repo
  getIt.registerLazySingleton<AzkarRepo>(() => AzkarRepo());
  getIt.registerLazySingleton<AyatRepo>(() => AyatRepo(getIt<ApiService>()));
  getIt.registerLazySingleton<QranRepo>(() => QranRepo(getIt<ApiService>()));
  getIt.registerLazySingleton<RadioRepo>(() => RadioRepo(getIt<ApiService>()));
  getIt.registerLazySingleton<PrayerRepo>(
    () => PrayerRepo(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<DoaaServices>(() => DoaaServices());
  getIt.registerLazySingleton<AzkarServices>(() => AzkarServices());

  getIt.registerLazySingleton<AllahNameRepo>(() => AllahNameRepo());
  getIt.registerLazySingleton<DoaaRepo>(() => DoaaRepo());
  // cubits
  getIt.registerLazySingleton<TasbehCubit>(
    () => TasbehCubit(getIt<TasbehServices>()),
  );
  getIt.registerLazySingleton<FavoriteCubit>(
    () => FavoriteCubit(getIt<DoaaServices>(), getIt<AzkarServices>()),
  );
  getIt.registerLazySingleton<QranServices>(() => QranServices());

  getIt.registerLazySingleton<AzkarCubit>(
    () => AzkarCubit(getIt<AzkarRepo>(), getIt<AzkarServices>()),
  );
  getIt.registerLazySingleton<PrayerCubit>(
    () => PrayerCubit(getIt<PrayerServices>()),
  );
  getIt.registerLazySingleton<AllahNameCubit>(
    () => AllahNameCubit(getIt<AllahNameRepo>()),
  );
  getIt.registerLazySingleton<DoaaCubit>(() => DoaaCubit(getIt<DoaaRepo>()));

  // with api
  getIt.registerLazySingleton<QranCubit>(() => QranCubit(getIt<QranRepo>()));
  getIt.registerLazySingleton<AyatCubit>(() => AyatCubit(getIt<AyatRepo>()));
  getIt.registerLazySingleton<RadioCubit>(() => RadioCubit(getIt<RadioRepo>()));
  getIt.registerLazySingleton<PrayerTimeCubit>(
    () => PrayerTimeCubit(getIt<PrayerRepo>()),
  );
  getIt.registerLazySingleton<GoogleMapCubit>(() => GoogleMapCubit());
}
