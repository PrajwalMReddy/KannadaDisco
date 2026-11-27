import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/resource_topic.dart';

/// All the topic grids on the home screen.
class Resources extends StatelessWidget {
  const Resources({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: allCards);
  }
}
