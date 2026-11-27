import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/course_units.dart';
import 'package:kannada_disco/const/theme.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/element/side_bar.dart';

/// The Courses tab.
class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Courses")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Full Kannada Course", style: context.sectionStyle),
                const SizedBox(height: 4),
                Text(
                  "${allCourseCards.length} lessons, from reading the script "
                  "to verb tenses. Each one builds on the last.",
                  style: text.bodyMedium,
                ),
              ],
            ),
          ),
          ...allCourseCards,
        ],
      ),
      drawer: const SideBar(),
      bottomNavigationBar: const BottomNavigation(currentPage: 1),
    );
  }
}
