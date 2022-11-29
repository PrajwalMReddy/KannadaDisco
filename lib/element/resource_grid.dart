import 'package:flutter/material.dart';
import 'package:kannada_disco/element/resource_card.dart';

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
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 20.0,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: cards,
            ),
          ),
        ),
      ],
    );
  }
}
