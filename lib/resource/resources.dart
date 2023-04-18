import 'package:flutter/material.dart';
import 'package:kannada_disco/const/resource_topic.dart';

class Resources extends StatelessWidget {
  const Resources({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> allCardsDisplay = [];
    for (var value in allCards) {
      allCardsDisplay.add(value);
      allCardsDisplay.add(const SizedBox(height: 20));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(children: allCardsDisplay),
      ),
    );
  }
}
