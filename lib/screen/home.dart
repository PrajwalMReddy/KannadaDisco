import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/element/reminder_prompt.dart';
import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/element/word_of_the_day.dart';
import 'package:kannada_disco/resource/resources.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KannadaDisco"),
        // Flush with the header below.
        scrolledUnderElevation: 0,
      ),
      drawer: const SideBar(),
      body: const HomeBody(),
      bottomNavigationBar: const BottomNavigation(currentPage: 0),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  static const _sheetOverlap = 24.0;

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;

    // The header and the topic sheet scroll together, so nothing is ever
    // hidden behind the sheet's edge.
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: headerGradient),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16 + _sheetOverlap),
            child: const Column(
              children: [WordOfTheDay(), ReminderPrompt()],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -_sheetOverlap),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: const Resources(),
            ),
          ),
        ],
      ),
    );
  }
}
