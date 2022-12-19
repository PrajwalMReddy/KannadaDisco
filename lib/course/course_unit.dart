import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class CourseUnit extends StatelessWidget {
  final String heading;
  final String subheading;

  const CourseUnit({Key? key, required this.heading, required this.subheading,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () => {},
        child: SizedBox(
          height: size.height * 0.2,
          width: size.width * 0.8,
          child: Card(
            margin: const EdgeInsets.fromLTRB(0.0, 00.0, 0.0, 20.0),
            color: kannadaYellow,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Column(
                    children: [
                      Text(
                        heading,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        subheading,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ),
        )
    );
  }
}
