import 'package:flutter/material.dart';
import 'package:kannada_disco/resource/resource_card.dart';

class ResourceList extends StatelessWidget {
  const ResourceList({
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
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 6.0),
            child: Text(
              type,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue
              ),
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: cards,
          ),
        ),
      ],
    );
  }
}