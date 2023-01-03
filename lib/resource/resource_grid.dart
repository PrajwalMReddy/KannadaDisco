import 'package:flutter/material.dart';
import 'package:kannada_disco/resource/resource_card.dart';

class ResourceGrid extends StatelessWidget {
  const ResourceGrid({
    Key? key,
    required this.type,
    required this.cards,
  }) : super(key: key);

  final String type;
  final List<ResourceCard> cards;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: Text(
              type,
              style: const TextStyle(
                fontSize: 20.0,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            children: cards,
          )
        ),
      ],
    );
  }
}
