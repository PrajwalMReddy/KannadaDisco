import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List pages = const [
    "/home",
    "",
    "/course",
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: kannadaRed,

      onTap: (index) {
        Navigator.pushReplacementNamed(context, pages[index]);
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
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
