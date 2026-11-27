import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/color.dart';

/// Bottom tabs: Home, Courses and Kids Section.
class BottomNavigation extends StatelessWidget {
  final int currentPage;

  const BottomNavigation({super.key, required this.currentPage});

  static const _routes = ["/home", "/course", "/kids"];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      selectedItemColor: kannadaBlue,
      onTap: (index) {
        if (index != currentPage) {
          Navigator.pushReplacementNamed(context, _routes[index]);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: "Courses"),
        BottomNavigationBarItem(
            icon: Icon(Icons.child_care), label: "Kids Section"),
      ],
    );
  }
}
