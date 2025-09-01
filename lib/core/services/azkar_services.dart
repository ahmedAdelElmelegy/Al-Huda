import 'package:al_huda/core/services/notification/notification_services.dart';
import 'package:al_huda/core/services/prayer_services.dart';
import 'package:al_huda/core/services/shared_pref_services.dart';
import 'package:al_huda/core/utils/constants.dart';
import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class AzkarServices {
  Future<void> azkarInit() async {
    bool isSabahOn = await PrayerServices.getSwitchState(
      0,
      Constants.keyPrefix,
    );
    bool isMassaaOn = await PrayerServices.getSwitchState(
      1,
      Constants.keyPrefix,
    );
    bool isOnlyOneAzkarNotificationOn =
        await SharedPrefServices.getBool(Constants.onlyOneAzkarNotification) ??
        false;
    TimeOfDay? zikrTimeSabah = await PrayerServices.convertStringToTimeOfDay(
      Constants.azkarKeySabah,
    );
    TimeOfDay? zikrTimeMassaa = await PrayerServices.convertStringToTimeOfDay(
      Constants.azkarKeyMassaa,
    );
    // only one azkar notification
    if (!isOnlyOneAzkarNotificationOn) {
      NotificationService.showPeriodicallyNotification(
        1002,
        "صلي علي محمد",
        "صلي الله عليه وسلم",
        sound: 'salyalmohamed',
        payload: 'sallehAlMohamed',
      );
      SharedPrefServices.setBool(true, Constants.onlyOneAzkarNotification);
    }

    // sabah
    if (isSabahOn) {
      NotificationService.scheduleNotification(
        1000,
        "أذكار الصباح",
        "اذكر الله صباحك",
        PrayerServices.calculateDataTime(
          zikrTimeSabah?.hour ?? 6,
          zikrTimeSabah?.minute ?? 0,
        ),
        sound: 'azkarsabahh',
        playSound: await PrayerServices.getSwitchState(
          0,
          Constants.keyPrefixAzkar,
        ),

        chanelId: Constants.azkarAlsabahChannelId,
        chanelName: "أذكار الصباح",
        payload: 'azkar',
      );
    } else {
      NotificationService.cancelNotification(1000);
    }

    // massaa
    if (isMassaaOn) {
      NotificationService.scheduleNotification(
        1001,
        "أذكار المساء",
        "اذكر الله مساءك",
        PrayerServices.calculateDataTime(
          zikrTimeMassaa?.hour ?? 18,
          zikrTimeMassaa?.minute ?? 0,
        ),
        sound: 'azkarmassaa',
        playSound: await PrayerServices.getSwitchState(
          1,
          Constants.keyPrefixAzkar,
        ),
        chanelId: Constants.azkarElmassaaChannelId,
        chanelName: "أذكار المساء",
        payload: 'azkar',
      );
    } else {
      NotificationService.cancelNotification(1001);
    }
  }

  //  for azkar add to hive
  static const String boxName = Constants.zikrBoxName;

  // create box
  Future<Box<Zikr>> openBox() async {
    return await Hive.openBox<Zikr>(boxName);
  }

  Future<void> addZikr(Zikr zikr) async {
    final box = await openBox();
    await box.add(zikr);
  }

  // get all zikr
  Future<List<Zikr>> getAllZikr() async {
    final box = await openBox();
    return box.values.toList();
  }

  Future<void> updateZikr(int index, Zikr zikr) async {
    final box = await openBox();
    await box.putAt(index, zikr);
  }

  Future<void> deleteZikr(int index) async {
    final box = await openBox();
    await box.deleteAt(index);
  }

  Future<void> clearAll() async {
    final box = await openBox();
    await box.clear();
  }

  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    debugPrint('Text copied to clipboard!');
  }
}
