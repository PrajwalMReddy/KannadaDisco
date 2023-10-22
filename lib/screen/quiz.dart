import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/const/course_units.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/util/screen_size.dart';
import 'package:kannada_disco/util/util.dart';

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
        title: const Text("Kids Section"),
        centerTitle: true,
        backgroundColor: kannadaBlue,
        elevation: 0.0,
      ),
  body: const CourseBody(),
      drawer: const SideBar(),
      bottomNavigationBar: BottomNavigation(currentPage: 2),
    );
  }
}

class CourseBody extends StatelessWidget {
  const CourseBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: grade1_2cards,
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 30, bottom: 30),
          //   child: Text(
          //         "Grade 3-5",
          //         style: TextStyle(
          //           fontSize: 20.0,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.blue,
          //         ),
          //       ),
          // ),
          //     Column(
          //   children: grade3_5cards,
          // ),
        ],
      ),
    );
  }
}
