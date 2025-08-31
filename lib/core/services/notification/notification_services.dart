import 'package:al_huda/core/utils/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz; // الاستيراد كـ tz
import 'package:timezone/data/latest_all.dart' as tz; // لتهيئة بيانات التوقيت

class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _localNotificationsPlugin.initialize(settings);
  }

  static Future<void> requestNotificationPermissions() async {
    // Android 13+
    final androidPlugin = _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();

    // iOS
    final iosPlugin = _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (iosPlugin != null) {
      await iosPlugin.requestPermissions(alert: true, badge: true, sound: true);
    }
  }

  static Future<void> cancelNotification(int id) async {
    await _localNotificationsPlugin.cancel(id);
  }

  static Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    DateTime scheduleTime, {
    bool playSound = true,
    String sound = 'athan',
    String chanelId = 'prayer_channel',
    String chanelName = 'مواعيد الصلاة',
  }) async {
    if (scheduleTime.isBefore(DateTime.now())) {
      return;
    }

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      chanelId, // Channel ID
      chanelName, // Channel Name
      importance: Importance.max,
      priority: Priority.high,
      playSound: playSound,
      icon: 'logo',
      sound: RawResourceAndroidNotificationSound(sound),
    );

    // تفاصيل الإشعار لنظام iOS
    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      sound: sound,
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails platformChannelDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleTime, tz.local),
      platformChannelDetails,

      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'prayer_channel',
      'Prayer Times',
      channelDescription: 'Default notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: 'logo',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotificationsPlugin.show(id, title, body, details);
  }

  static Future<void> showPeriodicallyNotification(
    int id,
    String title,
    String body, {
    bool playSound = true,
    String sound = 'salyalmohamed',
    String chanelId = Constants.saleAlMohamedChannelId,
    String chanelName = 'صلي علي محمد',
  }) async {
    AndroidNotificationDetails androidDaily = AndroidNotificationDetails(
      chanelId,
      chanelName,
      channelDescription: 'Notifications for daily azkar',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: 'logo',
      sound: RawResourceAndroidNotificationSound(sound),
    );

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      sound: '$sound.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDaily,
      iOS: iosDetails,
    );

    await _localNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      RepeatInterval.everyMinute,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
