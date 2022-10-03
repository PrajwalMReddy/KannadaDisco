import 'package:flutter/material.dart';

import 'package:kannada_disco/home.dart';
import 'package:kannada_disco/loading.dart';

void main() => runApp(
  MaterialApp(
    initialRoute: '/loading',
    routes: {
      '/': (context) => const Home(),
      '/loading': (context) => const Loading(),
    },
  ),
);
