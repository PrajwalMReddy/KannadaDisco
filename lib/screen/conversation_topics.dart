import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/course_units.dart';

/// The Kids section's list of conversations.
class ConversationTopics extends StatelessWidget {
  const ConversationTopics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conversations")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: conversationSubCards,
      ),
    );
  }
}
