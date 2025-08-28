import 'package:al_huda/app.dart';
import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/tasbeh_services.dart';
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
    final prayerServices = PrayerServices();
    final times = prayerServices.getPrayerTimes();
    await NotificationService.init();

    final prayerTimes = [
      MapEntry("fagr", times.fajr),
      MapEntry("shurooq", times.sunrise),
      MapEntry("dhuhr", times.dhuhr),
      MapEntry("asr", times.asr),
      MapEntry("maghrib", times.maghrib),
      MapEntry("isha", times.isha),
    ];

    for (int i = 0; i < prayerTimes.length; i++) {
      final prayer = prayerTimes[i];
      NotificationService.scheduleNotification(
        i,
        'حان الآن موعد ${prayer.key}',
        'وقت الصلاة: ${prayer.key}',
        prayer.value,
      );
    }
    debugPrint("✅ Task executed: $task at ${DateTime.now()}");
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await Workmanager().registerPeriodicTask(
    "dailyPrayerTask",
    "refreshPrayerTimes",
    initialDelay: PrayerServices.getDelayUnitMidnight(),
  );
  await NotificationService.init();
  await NotificationService.requestNotificationPermissions();

  await Hive.initFlutter();
  Hive.registerAdapter(TasbehModelAdapter());
  await TasbehServices().openBox();
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
