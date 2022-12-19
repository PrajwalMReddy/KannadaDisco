import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/util/util.dart';

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
        width: 160.0,
        child: Card(
          margin: const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 20.0),
          color: kannadaYellow,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                  prettifyTopic(topic),
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
