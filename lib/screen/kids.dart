import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/const/course_units.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/element/side_bar.dart';

/// The Kids section tab.
class KidsPage extends StatelessWidget {
  const KidsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kids Section"),
        centerTitle: true,
        backgroundColor: kannadaBlue,
        elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Center(child: Column(children: grade1_2cards)),
      ),
      drawer: const SideBar(),
      bottomNavigationBar: const BottomNavigation(currentPage: 2),
    );
  }
}
