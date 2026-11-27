import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/theme.dart';
import 'package:kannada_disco/resource/resource_card.dart';

/// A titled grid of topics on the home screen, e.g. "Vocabulary".
class ResourceGrid extends StatelessWidget {
  const ResourceGrid({
    super.key,
    required this.type,
    required this.cards,
  });

  final String type;
  final List<ResourceCard> cards;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(type, style: context.sectionStyle),
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // Room for three lines of the tile text at the user's font size.
              mainAxisExtent: ResourceCard.height(context),
            ),
            itemCount: cards.length,
            itemBuilder: (context, index) => cards[index],
          ),
        ],
      ),
    );
  }
}
