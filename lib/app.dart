import 'package:al_huda/bloc.dart';
import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/theme/colors.dart';
import 'package:al_huda/feature/splash/presentation/screen/splash_screen.dart';
import 'package:al_huda/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return ScreenUtilInit(
      designSize: isLandscape ? const Size(812, 375) : const Size(375, 812),
      builder: (context, child) {
        return GenerateMultiBloc(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigator,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            theme: ThemeData(
              dialogTheme: DialogThemeData(backgroundColor: ColorManager.white),
              primaryColor: ColorManager.primary,
              scaffoldBackgroundColor: Colors.white,

              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                surfaceTintColor: Colors.white,
              ),
            ),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}

class TestNotification extends StatelessWidget {
  const TestNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              NotificationService.scheduleNotification(
                800,
                'notification_on',
                'body',
                DateTime.now().add(Duration(seconds: 20)),
              );
            },
            child: Text('notification on'),
          ),
          ElevatedButton(
            onPressed: () {
              NotificationService.cancelNotification(800);
              NotificationService.scheduleNotification(
                800,
                'notification_on',
                'body',
                playSound: false,

                DateTime.now().add(Duration(seconds: 20)),
              );
            },
            child: Text('notification  mute'),
          ),
        ],
      ),
    );
  }
}
