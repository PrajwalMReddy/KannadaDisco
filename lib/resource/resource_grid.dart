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
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
            child: Text(
              type,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.3,
            crossAxisCount: 3,
            shrinkWrap: true,
            children: cards,
          ),
        ),
      ],
    );
  }
}
