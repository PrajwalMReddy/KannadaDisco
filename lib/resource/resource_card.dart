import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/util/screen_size.dart';
import 'package:kannada_disco/util/util.dart';

class ResourceCard extends StatelessWidget {
  final String topic;
  final String resourceType;

  const ResourceCard(
      {Key? key, required this.topic, required this.resourceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: () => {
    //     Navigator.pushNamed(context, "/res/$resourceType", arguments: {
    //       "topic": topic,
    //     })
    //   },
    //   child: Container(

    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       boxShadow:  [
    //   BoxShadow(
    //     color: Colors.red,
    //     blurRadius: 10.0, // soften the shadow
    //     spreadRadius: 0.0, //extend the shadow
    //     offset: Offset(
    //       3.0, // Move to right 10  horizontally
    //       3.0, // Move to bottom 10 Vertically
    //     ),
    //   )
    // ],
    //     ),
    //     child: Card(
    //       shadowColor: Colors.red,
    //       shape: RoundedRectangleBorder(
    //        borderRadius: BorderRadius.circular(100),
    //       ),
    //       margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
    //       color: kannadaYellow,
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Center(
    //           child: Text(
    // prettifyText(topic),
    // textAlign: TextAlign.center,
    // style: const TextStyle(
    //   fontSize: 16.0,
    //   fontWeight: FontWeight.w700
    // ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "/res/$resourceType", arguments: {
          "topic": topic,
        }),
      child: Container(
        height: ScreenSize.height! * 0.07,
        width: ScreenSize.width! * 0.4,
        child: Card(
          child: Center(
              child: Text(
            prettifyText(topic),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
          )),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
      ),
    );
  }
}
