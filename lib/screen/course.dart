import 'package:flutter/material.dart';

import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/side_bar.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KannadaDisco Courses"),
        centerTitle: true,
        backgroundColor: kannadaRed,
        elevation: 0.0,
      ),
      drawer: const SideBar(),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
