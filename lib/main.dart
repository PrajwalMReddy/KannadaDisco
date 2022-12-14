import 'package:flutter/material.dart';

import 'package:kannada_disco/screen//home.dart';
import 'package:kannada_disco/screen/course.dart';
import 'package:kannada_disco/screen/loading.dart';
import 'package:kannada_disco/screen/about.dart';
import 'package:kannada_disco/resource/reference.dart';
import 'package:kannada_disco/screen/settings.dart';
import 'package:kannada_disco/screen/usage.dart';

void main() => runApp(
  MaterialApp(
    initialRoute: '/loading',
    routes: {
      '/loading': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/course': (context) => const CoursePage(),

      '/usage': (context) => const Usage(),
      '/about': (context) => const About(),
      '/settings': (context) => const Settings(),

      // Resources
      '/res/reading': (context) => Reference(type: "reading"),
      '/res/vocabulary': (context) => Reference(type: "vocab"),
      '/res/tense': (context) => Reference(type: "tense"),
      '/res/grammar': (context) => Reference(type: "gram"),

      // Courses
      '/course/': (context) => const CoursePage(),
    },
  ),
);
