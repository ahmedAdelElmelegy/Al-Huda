import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:flutter/material.dart';

Future<void> saveAzkarTime(
  TimeOfDay? selectedTime,
  String? formattedTime,
  int index,
  String zikrName,
) async {
  if (selectedTime != null) {
    final formattedValue =
        "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}";
    if (index == 0) {}
    SharedPrefServices.setValue(formattedValue, 'time_$zikrName');
    if (index == 0) {
      NotificationService.cancelNotification(1000);
      NotificationService.scheduleNotification(
        1000,
        "أذكار الصباح",
        "اذكر الله صباحك",
        PrayerServices.calculateDataTime(
          selectedTime.hour,
          selectedTime.minute,
        ),
        sound: 'azkarsabahh',
        playSound: await PrayerServices.getSwitchState(
          0,
          Constants.keyPrefixAzkar,
        ),

        chanelId: Constants.azkarAlsabahChannelId,
        chanelName: "أذكار الصباح",
      );
    } else if (index == 1) {
      NotificationService.cancelNotification(1001);
      NotificationService.scheduleNotification(
        1001,
        "أذكار المساء",
        "اذكر الله مساءك",
        PrayerServices.calculateDataTime(
          selectedTime.hour,
          selectedTime.minute,
        ),
        sound: 'azkarmassaa',
        playSound: await PrayerServices.getSwitchState(
          1,
          Constants.keyPrefixAzkar,
        ),
        chanelId: Constants.azkarElmassaaChannelId,
        chanelName: "أذكار المساء",
      );
    }

    debugPrint('تم حفظ الوقت: time_$zikrName = $formattedValue');
  }
}
