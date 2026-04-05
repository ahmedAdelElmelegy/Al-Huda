import 'package:al_huda/bloc.dart';
import 'package:al_huda/core/theme/app_theme.dart';
import 'package:al_huda/feature/splash/presentation/screen/splash_screen.dart';
import 'package:al_huda/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Global theme mode notifier — toggled from the Settings screen.
final ValueNotifier<ThemeMode> appThemeMode =
    ValueNotifier<ThemeMode>(ThemeMode.light);

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
          child: ValueListenableBuilder<ThemeMode>(
            valueListenable: appThemeMode,
            builder: (_, themeMode, __) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navigator,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                theme: AppTheme.light(),
                darkTheme: AppTheme.dark(),
                themeMode: themeMode,
                home: const SplashScreen(),
              );
            },
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
    return const Scaffold(body: SizedBox.shrink());
  }
}
