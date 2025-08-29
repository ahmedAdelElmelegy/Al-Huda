import 'package:al_huda/app.dart';
import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/qran_services.dart';
import 'package:al_huda/core/services/tasbeh_services.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/tasbeh/data/model/tasbeh_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';
import 'core/services/notification/notification_services.dart';

GetIt getIt = GetIt.instance;
GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

/// ✨ مهم: لازم يكون top-level void + vm:entry-point
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final prayerServices = PrayerServices();
    final times = await prayerServices.getPrayerTimes();
    await NotificationService.init();

    final labels = {
      "fagr": "الفجر",
      "shurooq": "الشروق",
      "dhuhr": "الظهر",
      "asr": "العصر",
      "maghrib": "المغرب",
      "isha": "العشاء",
    };

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
      final scheduledTime = tz.TZDateTime.from(prayer.value, tz.local);
      NotificationService.scheduleNotification(
        i,
        'حان الآن موعد ${labels[prayer.key]}',
        'وقت الصلاة: ${labels[prayer.key]}',
        scheduledTime,
        playSound: await PrayerServices.getSwitchState(
          i,
          Constants.keyPrefixNotification,
        ),
      );
    }

    debugPrint("✅ Task executed: $task at ${DateTime.now()}");
    return Future.value(true);
  });
}

@pragma('vm:entry-point')
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  debugPrint("✅ Workmanager initialized");

  await Workmanager().registerPeriodicTask(
    "dailyPrayerTask",
    "refreshPrayerTimes",
    frequency: const Duration(hours: 24),
    initialDelay: PrayerServices.getDelayUnitMidnight(),
  );

  await NotificationService.init();
  await NotificationService.requestNotificationPermissions();

  bool isSabahOn = await PrayerServices.getSwitchState(0, Constants.keyPrefix);
  bool isMassaaOn = await PrayerServices.getSwitchState(1, Constants.keyPrefix);
  bool isOnlyOneAzkarNotificationOn =
      await SharedPrefServices.getBool(Constants.onlyOneAzkarNotification) ??
      false;
  if (!isOnlyOneAzkarNotificationOn) {
    NotificationService.showPeriodicallyNotification(
      5000,
      "sally_al_mohamed".tr(),
      "sally_al_mohamed".tr(),
      sound: 'salyalmohamed',
    );
    SharedPrefServices.setBool(true, Constants.onlyOneAzkarNotification);
  }
  if (isSabahOn) {
    NotificationService.scheduleDailyNotification(
      1000,
      "أذكار الصباح",
      "اذكر الله صباحك",
      4,
      40,
      sound: 'azkarsabahh',
      playSound: await PrayerServices.getSwitchState(
        0,
        Constants.keyPrefixAzkar,
      ),
    );
  } else {
    NotificationService.cancelNotification(1000);
  }

  if (isMassaaOn) {
    NotificationService.scheduleDailyNotification(
      1001,
      "أذكار المساء",
      "اذكر الله مساءك",
      18,
      0,
      sound: 'azkarmassaa',
      playSound: await PrayerServices.getSwitchState(
        1,
        Constants.keyPrefixAzkar,
      ),
    );
  } else {
    NotificationService.cancelNotification(1001);
  }

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
