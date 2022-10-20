import 'package:flutter/material.dart';

import 'package:kannada_disco/screen//home.dart';
import 'package:kannada_disco/screen/loading.dart';
import 'package:kannada_disco/screen/about.dart';
import 'package:kannada_disco/screen/resources/pronoun_resource_page.dart';

void main() => runApp(
  MaterialApp(
    initialRoute: '/loading',
    routes: {
      '/home': (context) => const Home(),
      '/loading': (context) => const Loading(),
      '/about': (context) => const About(),

      // Resources
      '/resources/pronouns': (context) => const PronounResourcePage(),
    },
  ),
);
