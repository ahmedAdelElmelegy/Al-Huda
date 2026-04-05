import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service to handle battery optimization settings
/// This is critical for prayer notifications to work in battery saver mode
class BatteryOptimizationService {
  /// Check if the app is ignoring battery optimizations
  static Future<bool> isIgnoringBatteryOptimizations() async {
    if (!Platform.isAndroid) return true;

    try {
      // Use permission_handler to check battery optimization status
      final status = await Permission.ignoreBatteryOptimizations.status;
      return status.isGranted;
    } catch (e) {
      debugPrint('Error checking battery optimization status: $e');
      return false;
    }
  }

  /// Request to ignore battery optimizations
  static Future<bool> requestIgnoreBatteryOptimizations() async {
    if (!Platform.isAndroid) return true;

    try {
      final status = await Permission.ignoreBatteryOptimizations.request();
      return status.isGranted;
    } catch (e) {
      debugPrint('Error requesting battery optimization: $e');
      return false;
    }
  }

  /// Open battery optimization settings for the app
  static Future<void> openBatteryOptimizationSettings() async {
    if (!Platform.isAndroid) return;

    try {
      await AppSettings.openAppSettings(
        type: AppSettingsType.batteryOptimization,
      );
    } catch (e) {
      debugPrint('Error opening battery settings: $e');
      // Fallback: open general app settings
      await AppSettings.openAppSettings(type: AppSettingsType.settings);
    }
  }

  /// Check and request all critical permissions for prayer notifications
  static Future<Map<String, bool>> checkCriticalPermissions() async {
    final Map<String, bool> permissions = {};

    if (!Platform.isAndroid) {
      permissions['battery_optimization'] = true;
      permissions['exact_alarm'] = true;
      permissions['notification'] = true;
      return permissions;
    }

    // Check notification permission
    final notificationStatus = await Permission.notification.status;
    permissions['notification'] = notificationStatus.isGranted;

    // Check exact alarm permission (Android 12+)
    final exactAlarmStatus = await Permission.scheduleExactAlarm.status;
    permissions['exact_alarm'] = exactAlarmStatus.isGranted;

    // Check battery optimization
    final batteryStatus = await Permission.ignoreBatteryOptimizations.status;
    permissions['battery_optimization'] = batteryStatus.isGranted;

    return permissions;
  }

  /// Request all critical permissions
  static Future<Map<String, bool>> requestCriticalPermissions() async {
    final Map<String, bool> results = {};

    if (!Platform.isAndroid) {
      results['battery_optimization'] = true;
      results['exact_alarm'] = true;
      results['notification'] = true;
      return results;
    }

    // Request notification permission
    final notificationStatus = await Permission.notification.request();
    results['notification'] = notificationStatus.isGranted;

    // Request exact alarm permission
    final exactAlarmStatus = await Permission.scheduleExactAlarm.request();
    results['exact_alarm'] = exactAlarmStatus.isGranted;

    // Request battery optimization (requires special handling)
    final batteryStatus = await Permission.ignoreBatteryOptimizations.request();
    results['battery_optimization'] = batteryStatus.isGranted;

    return results;
  }

  /// Show a dialog explaining why battery optimization needs to be disabled
  static Future<void> showBatteryOptimizationDialog(
    BuildContext context, {
    VoidCallback? onGranted,
    VoidCallback? onDismissed,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.battery_alert, color: Colors.orange),
              SizedBox(width: 8),
              Text('تنبيه مهم'),
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'لضمان عمل تنبيهات الصلاة بشكل صحيح، يجب السماح للتطبيق بالعمل في الخلفية.',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Text(
                  '⚠️ بدون هذا الإذن، قد لا تعمل التنبيهات في وضع توفير البطارية',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'انقر على "السماح" ثم اختر "كل الإعدادات" وابحث عن "تحسين البطارية"',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDismissed?.call();
              },
              child: const Text('لاحقاً'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final granted = await requestIgnoreBatteryOptimizations();
                if (granted) {
                  onGranted?.call();
                } else {
                  // If direct request failed, open settings
                  await openBatteryOptimizationSettings();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('السماح'),
            ),
          ],
        );
      },
    );
  }

  /// Show exact alarm permission dialog
  static Future<void> showExactAlarmDialog(
    BuildContext context, {
    VoidCallback? onGranted,
    VoidCallback? onDismissed,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.alarm, color: Colors.blue),
              SizedBox(width: 8),
              Text('إذن التنبيهات الدقيقة'),
            ],
          ),
          content: const SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'لتنبيهك في أوقات الصلاة بدقة، يحتاج التطبيق إذن "التنبيهات الدقيقة"',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Text(
                  '⚠️ بدون هذا الإذن، قد تتأخر التنبيهات عدة دقائق',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDismissed?.call();
              },
              child: const Text('لاحقاً'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final status = await Permission.scheduleExactAlarm.request();
                if (status.isGranted) {
                  onGranted?.call();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('منح الإذن'),
            ),
          ],
        );
      },
    );
  }

  /// Check if all critical permissions are granted
  static Future<bool> hasAllCriticalPermissions() async {
    final permissions = await checkCriticalPermissions();
    return permissions.values.every((granted) => granted);
  }

  /// Show permission checker dialog on app start
  static Future<void> checkAndRequestPermissionsOnStart(
    BuildContext context,
  ) async {
    if (!Platform.isAndroid) return;

    final permissions = await checkCriticalPermissions();

    // Check notification permission
    if (!(permissions['notification'] ?? false)) {
      await Permission.notification.request();
    }

    // Check exact alarm permission
    if (!(permissions['exact_alarm'] ?? false)) {
      if (context.mounted) {
        await showExactAlarmDialog(context);
      }
    }

    // Check battery optimization
    if (!(permissions['battery_optimization'] ?? false)) {
      if (context.mounted) {
        await showBatteryOptimizationDialog(context);
      }
    }
  }
}
