import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class ResourceCard extends StatelessWidget {
  final String topic;
  final String resourceType;

  const ResourceCard({Key? key, required this.topic, required this.resourceType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, "/res/$resourceType", arguments: {
          "topic": topic,
        })
      },
      child: SizedBox(
        height: 100.0,
        width: 150.0,
        child: Card(
          margin: const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 20.0),
          color: kannadaYellow,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                  "${topic[0].toUpperCase()}${topic.substring(1).toLowerCase()}",
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}
