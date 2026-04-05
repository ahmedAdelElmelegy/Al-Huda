import 'package:al_huda/app.dart';
import 'package:al_huda/core/di/injection.dart';

import 'package:al_huda/core/services/battery_optimization_service.dart';
import 'package:al_huda/core/services/prayer_services.dart';

import 'package:al_huda/core/services/tasbeh_services.dart';

import 'package:al_huda/feature/hifz/data/model/hifz_model.dart';
import 'package:al_huda/feature/family/data/model/family_member.dart';
import 'package:al_huda/feature/family/data/repo/family_repo.dart';
import 'package:al_huda/feature/qran/presentation/manager/bookmark/bookmark_service.dart';
import 'package:al_huda/core/services/explore_history_service.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:al_huda/hive_registrar.g.dart';
import 'package:timezone/data/latest_all.dart' as tz;
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

  // Set status bar and ensure portrait only
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await EasyLocalization.ensureInitialized();

  // Initialize Hive before runApp (required by many screens)
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox('completedPrayersBox');

  await Hive.openBox('doaaDaily');
  await Hive.openBox('ramadan_box');
  await Hive.openBox<HifzVerse>('hifz_verses');
  await Hive.openBox<FamilyMember>(FamilyRepo.boxName);
  await Hive.openBox(TasbehServices.statsBoxName);
  await BookmarkService.init();
  await ExploreHistoryService.init();

  tz.initializeTimeZones();

  // Initialize dependency injection
  init();

  // Initialize notifications
  await NotificationService.init();
  await NotificationService.requestNotificationPermissions();

  // Run the app FIRST so the UI shows immediately
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      startLocale: const Locale('ar', 'EG'),
      fallbackLocale: const Locale('ar', 'EG'),
      child: MyApp(),
    ),
  );

  // Schedule background work AFTER the app is visible
  _initBackgroundServices();
}

/// Initialize background services after the app starts
void _initBackgroundServices() async {
  // Initialize WorkManager
  await Workmanager().initialize(callbackDispatcher);
  debugPrint("✅ Workmanager initialized");

  await Workmanager().registerPeriodicTask(
    "dailyPrayerTask",
    "refreshPrayerTimes",
    frequency: const Duration(hours: 24),
    initialDelay: PrayerServices.getDelayUnitMidnight(),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
    constraints: Constraints(requiresBatteryNotLow: false),
  );

  // Schedule prayer notifications
  await PrayerServices.runFirstTimeTask();

  // Check critical permissions after first frame renders
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _checkCriticalPermissions();
  });
}

/// Check and request critical permissions for prayer notifications
void _checkCriticalPermissions() async {
  final context = navigator.currentContext;
  if (context == null) return;

  final hasPermissions =
      await BatteryOptimizationService.hasAllCriticalPermissions();

  if (!context.mounted) return;

  if (!hasPermissions) {
    await BatteryOptimizationService.checkAndRequestPermissionsOnStart(context);
  }
}
