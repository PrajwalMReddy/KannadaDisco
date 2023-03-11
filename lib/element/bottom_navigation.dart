import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';

class BottomNavigation extends StatefulWidget {
  int currentPage;
  BottomNavigation({Key? key, required this.currentPage}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState(this.currentPage);
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  final List pages = const [
    "/home",
    "/course",
    "/quiz",
  ];

  _BottomNavigationState(int currentPage) {
    currentIndex = currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: kannadaBlue,

      onTap: (index) {
        Navigator.pushReplacementNamed(context, pages[index]);
      },

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: "Courses",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: "Practice",
        ),
      ],
    );
  }
}
