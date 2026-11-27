import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/element/unit_card.dart';
import 'package:kannada_disco/screen/conversation_topics.dart';
import 'package:kannada_disco/screen/rhymes_list.dart';
import 'package:kannada_disco/util/util.dart';

/// A lesson in the full Kannada course.
class CourseUnit extends StatelessWidget {
  final int number;
  final String heading;
  final String subheading;

  const CourseUnit(
      {super.key,
      required this.number,
      required this.heading,
      required this.subheading});

  @override
  Widget build(BuildContext context) {
    return UnitCard(
      title: prettifyText(heading),
      subtitle: subheading,
      kannadaSubtitle: false,
      leading: NumberBadge(number),
      onTap: () => Navigator.pushNamed(context, "/course/content",
          arguments: {"heading": heading}),
    );
  }
}

/// A topic in the Kids section.
class KidsUnit extends StatelessWidget {
  final String heading;
  final String kannadaHeading;
  final String topic;
  final String resourceType;

  const KidsUnit({
    super.key,
    required this.heading,
    required this.kannadaHeading,
    required this.topic,
    required this.resourceType,
  });

  @override
  Widget build(BuildContext context) {
    return UnitCard(
      title: heading,
      subtitle: kannadaHeading,
      leading: EmojiBadge(kidsEmoji[topic] ?? '📘'),
      onTap: () {
        if (resourceType == "conversation") {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const ConversationTopics()));
        } else if (topic == "rhymes") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      RhymesList(type: resourceType, topic: topic)));
        } else {
          openKidsReference(context, resourceType, topic, heading);
        }
      },
    );
  }
}

/// One conversation in the Kids section's conversation list.
class SubCardUnit extends StatelessWidget {
  final String heading;
  final String kannadaHeading;
  final String topic;
  final String resourceType;

  const SubCardUnit({
    super.key,
    required this.heading,
    required this.kannadaHeading,
    required this.topic,
    required this.resourceType,
  });

  @override
  Widget build(BuildContext context) {
    return UnitCard(
      title: heading,
      subtitle: kannadaHeading,
      leading: EmojiBadge(kidsEmoji[topic] ?? '💬'),
      onTap: () => openKidsReference(context, resourceType, topic, heading),
    );
  }
}

/// The picture shown beside each Kids section topic.
const Map<String, String> kidsEmoji = {
  'rhymes': '🎵',
  'friendsconv': '💬',
  'fruits': '🍎',
  'vegetables': '🥕',
  'colors': '🎨',
  'flowers': '🌸',
  'animals': '🐘',
  'birds': '🦜',
  'body_parts': '🖐️',
  'antonyms': '↔️',
  'teachersconv': '🧑‍🏫',
  'familyconv': '👨‍👩‍👧',
  'neighborscov': '🏘️',
  'copassconv': '🚌',
};

/// Opens a word list in Kids mode, which shows a custom heading and hides
/// entries whose "link" is an empty string (words with no kids picture).
void openKidsReference(
    BuildContext context, String resourceType, String topic, String heading) {
  Navigator.pushNamed(context, "/res/$resourceType",
      arguments: {"topic": topic, "heading": heading, "kids": true});
}
