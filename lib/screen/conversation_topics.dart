import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/const/course_units.dart';

/// The Kids section's list of conversations.
class ConversationTopics extends StatelessWidget {
  const ConversationTopics({super.key});

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
        child: Center(child: Column(children: conversationSubCards)),
      ),
    );
  }
}
