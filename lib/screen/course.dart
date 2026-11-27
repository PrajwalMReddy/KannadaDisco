import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/const/course_units.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/element/side_bar.dart';

/// The Courses tab.
class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KannadaDisco Courses"),
        centerTitle: true,
        backgroundColor: kannadaBlue,
        elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(35.0, 35.0, 35.0, 30.0),
                child: Text(
                  "Full Kannada Course",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              ...allCourseCards,
            ],
          ),
        ),
      ),
      drawer: const SideBar(),
      bottomNavigationBar: const BottomNavigation(currentPage: 1),
    );
  }
}
