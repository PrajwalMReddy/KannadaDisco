import 'dart:ffi';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class LocalNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  SharedPreferences? _prefs;
  Future<void> scheduleDailyNotification() async {
    _prefs = await SharedPreferences.getInstance();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '0',
      'KannadaDisco',
      'Show notification every day morining',
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
      playSound: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
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
        'Good Morining!',
        'Word of the day is ready for you, Please click here.',
        Time(hour, minute, second),
        platformChannelSpecifics);

//     var dateTime = DateTime(DateTime.now().year, DateTime.now().month,
//     DateTime.now().day, 18, 2, 0);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//   0,
//   'scheduled title',
//   'scheduled body',
//   tz.TZDateTime.from(dateTime, tz.local),
//   platformChannelSpecifics,
//   androidAllowWhileIdle: true,
//   uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//   matchDateTimeComponents: DateTimeComponents.time,
// );

//  // Initialize timezone database
//   tz.initializeTimeZones();

// //  // Get the local timezone
// //   String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
// //   tz.setLocalLocation(tz.getLocation(timeZoneName));

//   // Create a TZDateTime object for today at 7am
//   var now = tz.TZDateTime.now(tz.local);
//   var scheduledNotificationDateTime =
//       tz.TZDateTime(tz.local, now.year, now.month, now.day, 7);

//   // If it's already past 7am, schedule the notification for tomorrow at 7am instead
//   if (now.hour >= 7) {
//     scheduledNotificationDateTime = scheduledNotificationDateTime.add(Duration(days: 1));
//   }

//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'Daily Notification',
//     'This is your daily notification',
//     scheduledNotificationDateTime,
//     platformChannelSpecifics,
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//     payload: 'payload',
//     matchDateTimeComponents: DateTimeComponents.time,
//   );


  }
}
