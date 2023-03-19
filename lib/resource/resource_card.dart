import 'package:flutter/material.dart';
import 'package:kannada_disco/util/util.dart';

class ResourceCard extends StatelessWidget {
  final String topic;
  final String resourceType;

  const ResourceCard(
      {Key? key, required this.topic, required this.resourceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, "/res/$resourceType", arguments: {
        "topic": topic,
      }),
      child: SizedBox(
        // height: ScreenSize.height! * 0.07,
        // width: ScreenSize.width! * 0.4,
        child: Card(
          elevation: 15.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15)
              // Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              prettifyText(topic),
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
