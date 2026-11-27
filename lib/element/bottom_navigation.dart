import 'package:material_ui/material_ui.dart';

/// Bottom tabs: Home, Courses and Kids.
class BottomNavigation extends StatelessWidget {
  final int currentPage;

  const BottomNavigation({super.key, required this.currentPage});

  static const _routes = ["/home", "/course", "/kids"];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentPage,
      onDestinationSelected: (index) {
        if (index != currentPage) {
          Navigator.pushReplacementNamed(context, _routes[index]);
        }
      },
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home"),
        NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: "Courses"),
        NavigationDestination(
            icon: Icon(Icons.child_care_outlined),
            selectedIcon: Icon(Icons.child_care),
            label: "Kids"),
      ],
    );
  }
}
