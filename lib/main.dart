import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kannada_disco/screen/home.dart';
import 'package:kannada_disco/screen/course.dart';
import 'package:kannada_disco/screen/loading.dart';
import 'package:kannada_disco/screen/about.dart';
import 'package:kannada_disco/resource/reference.dart';
import 'package:kannada_disco/screen/settings.dart';
import 'package:kannada_disco/screen/usage.dart';
import 'package:kannada_disco/course/course_content.dart';
import 'package:kannada_disco/screen/quiz.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

  // Initialize the local notification plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('logo');
  var initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/loading',
    routes: {
      '/loading': (context) => const Loading(),
      '/home': (context) => const Home(),

      '/usage': (context) => const Usage(),
      '/about': (context) => const About(),
      '/settings': (context) => const Settings(), 

      // Resources
      '/res/reading': (context) => Reference(type: "reading"),
      '/res/vocabulary': (context) => Reference(type: "vocab"),
      '/res/grammar': (context) => Reference(type: "gram"),
      '/res/conversation': (context) => Reference(type: "conv"),

      // Courses
      '/course': (context) => const CoursePage(),
      '/course/content': (context) => CourseContent(),

      // Quizzes
      '/quiz': (context) => const QuizPage(),
    },
  ),
);
}
