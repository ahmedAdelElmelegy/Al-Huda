import 'package:al_huda/app.dart';
import 'package:al_huda/core/di/injection.dart';
import 'package:al_huda/core/services/tasbeh_services.dart';
import 'package:al_huda/feature/tasbeh/data/model/tasbeh_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EasyLocalization.ensureInitialized();
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

// https://api.alquran.cloud/v1/surah/1/ar.alafasy
// https://api.alquran.cloud/v1/surah
