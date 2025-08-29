import 'package:al_huda/bloc.dart';
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

// class NotifictionText extends StatelessWidget {
//   const NotifictionText({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             NotificationService.showPeriodicallyNotification(
//               5000,
//               'sally_al_mohamed'.tr(),
//               'sally_al_mohamed'.tr(),
//               sound: 'salyalmohamed',
//             );
//           },
//           child: Text("Pick Time"),
//         ),
//       ),
//     );
//   }
// }
// class NotifictionText extends StatefulWidget {
//   const NotifictionText({super.key});

//   @override
//   State<NotifictionText> createState() => _NotifictionTextState();
// }

// class _NotifictionTextState extends State<NotifictionText> {
//   TimeOfDay? pickedTime;

//   Future<void> pickTime(BuildContext context) async {
//     final TimeOfDay? time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (time != null) {
//       setState(() {
//         pickedTime = time;
//       });
//     }
//   }

//   DateTime getDateTimeFromTimeOfDay(TimeOfDay time) {
//     final now = DateTime.now();
//     DateTime dateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//     // If time already passed today, schedule for tomorrow
//     if (dateTime.isBefore(now)) {
//       dateTime = dateTime.add(Duration(days: 1));
//     }
//     return dateTime;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               onPressed: () => pickTime(context),
//               child: Text("Pick Time"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (pickedTime != null) {
//                   DateTime scheduledTime = getDateTimeFromTimeOfDay(
//                     pickedTime!,
//                   );
//                   NotificationService.scheduleNotification(
//                     1000,
//                     "Reminder",
//                     "It's time for your dhikr",
//                     scheduledTime,
//                     sound: 'azkarsabahh',
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Notification scheduled!')),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please pick a time first')),
//                   );
//                 }
//               },
//               child: Text("Schedule Notification"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
