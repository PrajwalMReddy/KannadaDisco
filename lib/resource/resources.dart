import 'package:flutter/material.dart';
import 'package:kannada_disco/const/resource_topic.dart';

class Resources extends StatelessWidget {
  const Resources({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: allCards,  
        ),
      ),
    );
  }
}
