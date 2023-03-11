import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';
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
        title: const Text("KannadaDisco Practice"),
        centerTitle: true,
        backgroundColor: kannadaBlue,
        elevation: 0.0,
      ),
      body: Center(
        // child: CourseUnit(heading: 'Quizzes', subheading: 'Coming Soon...'),
        child: GestureDetector(
          onTap: () => {},
          child: SizedBox(
            height: ScreenSize.height! * 0.2,
            width: ScreenSize.width! * 0.8,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              margin: const EdgeInsets.fromLTRB(0.0, 00.0, 0.0, 20.0),
              // color: kannadaYellow,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Column(children: [
                    Text(
                      prettifyText('Practice'),
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    const Text(
                      'Coming soon...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: const SideBar(),
      bottomNavigationBar: BottomNavigation(currentPage: 2),
    );
  }
}
