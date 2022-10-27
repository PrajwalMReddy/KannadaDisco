import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: kannadaRed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: "Resources",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: "Quizzes",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: "Courses",
        ),
      ],
    );
  }
}
