import 'package:flutter/material.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/const/course_units.dart';

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
      body: const CourseBody(),
      drawer: const SideBar(),
      bottomNavigationBar: BottomNavigation(currentPage: 1),
    );
  }
}

class CourseBody extends StatelessWidget {
  const CourseBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(35.0, 35.0, 35.0, 30.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Full Kannada Course",
                style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Column(
            children: allCourseCards,
          )
        ],
      ),
    );
  }
}
