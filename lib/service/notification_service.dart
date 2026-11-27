import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:kannada_disco/util/prefs_keys.dart';

/// Schedules the daily "word of the day" reminder.
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const int _dailyNotificationId = 0;
  static const String defaultTime = "07:00";

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  bool get _supported => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  Future<void> init() async {
    if (_initialized || !_supported) return;

    tz_data.initializeTimeZones();
    try {
      final timeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZone.identifier));
    } catch (_) {
      // Fall back to the timezone package's default (UTC).
    }

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('logo'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    try {
      await _plugin.initialize(settings: settings);
      _initialized = true;
    } catch (e) {
      // Never stop the app from starting over a notification problem; the
      // reminder just stays off. In release builds this happened once when
      // the 'logo' drawable was stripped (see android/.../res/raw/keep.xml).
      debugPrint('Notifications unavailable: $e');
    }
  }

  /// Whether reminders can work on this device at all (after [init]).
  bool get isAvailable => _initialized;

  /// Whether notifications are already allowed, without asking the user.
  Future<bool> notificationsAllowed() async {
    await init();
    if (!_initialized) return false;

    try {
      if (Platform.isAndroid) {
        final android = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        return await android?.areNotificationsEnabled() ?? false;
      }
      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      return (await ios?.checkPermissions())?.isEnabled ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Asks the user for notification permission. Returns true if granted.
  Future<bool> requestPermission() async {
    await init();
    if (!_initialized) return false;

    if (Platform.isAndroid) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await android?.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    return await ios?.requestPermissions(
            alert: true, badge: true, sound: true) ??
        false;
  }

  /// The saved reminder time as "HH:mm".
  static Future<String> savedTime() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(PrefsKeys.notificationTime) ?? defaultTime;
    // Older versions stored "HH:mm:ss".
    return saved.split(':').take(2).join(':');
  }

  static Future<void> saveTime(int hour, int minute) async {
    final prefs = await SharedPreferences.getInstance();
    final value =
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    await prefs.setString(PrefsKeys.notificationTime, value);
  }

  /// (Re)schedules the daily reminder at the saved time.
  Future<bool> scheduleDailyNotification() async {
    await init();
    if (!_initialized) return false;

    try {
      final prefs = await SharedPreferences.getInstance();
      final word = prefs.getString(PrefsKeys.nextWord) ?? defaultWord;
      final parts = (await savedTime()).split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final now = tz.TZDateTime.now(tz.local);
      var next =
          tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
      if (!next.isAfter(now)) {
        next = next.add(const Duration(days: 1));
      }

      const details = NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_word',
          'Word of the day',
          channelDescription: 'Daily reminder with a new Kannada word',
          importance: Importance.high,
          priority: Priority.high,
          icon: 'logo',
        ),
        iOS: DarwinNotificationDetails(),
      );

      await _plugin.cancel(id: _dailyNotificationId);
      await _plugin.zonedSchedule(
        id: _dailyNotificationId,
        title: 'ನಮಸ್ಕಾರ | Namaskāra 🙏',
        body: 'Word of the day: $word',
        scheduledDate: next,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  static const String defaultWord = "ನಮಸ್ಕಾರ - namaskāra - hello";
}
