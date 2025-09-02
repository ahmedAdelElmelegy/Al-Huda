import 'package:al_huda/app.dart';
import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/core/services/azkar_services.dart';
import 'package:al_huda/core/services/doaa_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/qran_services.dart';
import 'package:al_huda/core/services/tasbeh_services.dart';
import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:al_huda/feature/doaa/data/model/doaa_model.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/ayat.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/edition.dart';
import 'package:al_huda/feature/qran/data/model/ayat_model/surah_model_data.dart';
import 'package:al_huda/feature/qran/data/model/surah_model/surah_data.dart';
import 'package:al_huda/feature/tasbeh/data/model/tasbeh_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:workmanager/workmanager.dart';
import 'core/services/notification/notification_services.dart';

GetIt getIt = GetIt.instance;
GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await PrayerServices.workManagerTask();

    debugPrint("✅ Task executed: $task at ${DateTime.now()}");
    return Future.value(true);
  });
}

@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Workmanager().initialize(callbackDispatcher);
  debugPrint("✅ Workmanager initialized");

  await Workmanager().registerPeriodicTask(
    "dailyPrayerTask",
    "refreshPrayerTimes",
    frequency: const Duration(hours: 24),
    initialDelay: PrayerServices.getDelayUnitMidnight(),
  );

  await NotificationService.init();
  await NotificationService.requestNotificationPermissions();
  // azkar
  await AzkarServices().azkarInit();

  await Hive.initFlutter();
  Hive.registerAdapter(TasbehModelAdapter());
  Hive.registerAdapter(ZikrAdapter());
  Hive.registerAdapter(DoaaModelDataAdapter());
  Hive.registerAdapter(SurahDataAdapter());
  Hive.registerAdapter(SurahModelDataAdapter());
  Hive.registerAdapter(AyahAdapter());
  Hive.registerAdapter(EditionAdapter());
  await TasbehServices().openBox();
  await DoaaServices().openBox();
  await QranServices().openBox();
  await QranServices().openBoxAyah();

  await TasbehServices().initTasbeh();

  init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      startLocale: const Locale('ar', 'EG'),
      fallbackLocale: const Locale('ar', 'EG'),
      child: MyApp(),
    ),
  );
}
