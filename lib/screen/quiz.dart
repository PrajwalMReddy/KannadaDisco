import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/course/course_unit.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/element/side_bar.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KannadaDisco Quizzes"),
        centerTitle: true,
        backgroundColor: kannadaRed,
        elevation: 0.0,
      ),
      body: Center(
        child: CourseUnit(heading: 'Quizzes', subheading: 'Coming Soon...'),
      ),
      drawer: const SideBar(),
      bottomNavigationBar: BottomNavigation(currentPage: 2),
    );
  }
}
