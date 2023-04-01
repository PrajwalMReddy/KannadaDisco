import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  SharedPreferences? _prefs;
  Future<bool> scheduleDailyNotification() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      'KannadaDisco',
      channelDescription: 'Show notification every day morining',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
      playSound: true,
      icon: 'logo'
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
   var time = _prefs!.getString('notificationTime') ?? "07:00:00";
   var splisttedList = time.split(':');
   int hour = int.parse(splisttedList[0]);
   int minute = int.parse(splisttedList[1]);
   int second = int.parse(splisttedList[2]);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'ನಮಸ್ಕಾರ | Namaskāra 🙏',
        'There is a new word of the day available. Please visit KannadaDisco to learn its meaning.',
        Time(hour, minute, second),
        platformChannelSpecifics);
    return true;
    } catch (e) {
        Fluttertoast.showToast(
      msg: "Please Enter Valid Time Format",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
      print("Something went wrong");
      return false;
    }
    

  }
}
