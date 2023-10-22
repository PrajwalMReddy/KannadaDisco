import 'package:flutter/material.dart';
import 'package:kannada_disco/screen/rhymes_subcard_screen.dart';
import 'package:kannada_disco/screen/subcard_screen.dart';
import 'package:kannada_disco/util/util.dart';

class CourseUnit extends StatelessWidget {
  final String heading;
  final String subheading;

  const CourseUnit({
    Key? key,
    required this.heading,
    required this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, "/course/content", arguments: {
          "heading": heading,
        })
      },
      child: SizedBox(
        height: size.height * 0.2,
        width: size.width * 0.8,
        child: Card(
          elevation: 15,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            topRight: Radius.circular(100),
            topLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          )),
          margin: const EdgeInsets.fromLTRB(0.0, 00.0, 0.0, 20.0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(children: [
                Text(
                  prettifyText(heading),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  subheading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.w500),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class KidsUnit extends StatelessWidget {
  final String heading;
  final String kannadaHeading;
  final String topic;
  final String resourceType;
  const KidsUnit({super.key, required this.heading, required this.kannadaHeading, required this.topic, required this.resourceType});

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (resourceType == "conversation") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SubcardScreen(),));
        } else if (topic == "rhymes") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RhymesSubCardScreen(type: resourceType, topic: topic),));

        }
        else {
          Navigator.pushNamed(context, "/res/$resourceType", arguments: {
        "topic": topic,
        "heading": heading
      });
        }
         
      },
      child: SizedBox(
        height: size.height * 0.22,
        width: size.width * 0.8,
        child: Card(
          elevation: 15,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            topRight: Radius.circular(100),
            topLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          )),
          margin: const EdgeInsets.fromLTRB(0.0, 00.0, 0.0, 20.0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(children: [
                Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    kannadaHeading,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.blue),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class SubCardUnit extends StatelessWidget {
  final String heading;
  final String kannadaHeading;
  final String topic;
  final String resourceType;
  const SubCardUnit({super.key, required this.heading, required this.kannadaHeading, required this.topic, required this.resourceType});

  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
         Navigator.pushNamed(context, "/res/$resourceType", arguments: {
        "topic": topic,
        "heading": heading
      });
      },
      child: SizedBox(
        height: size.height * 0.22,
        width: size.width * 0.8,
        child: Card(
          elevation: 15,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(100),
            topRight: Radius.circular(100),
            topLeft: Radius.circular(100),
            bottomRight: Radius.circular(100),
          )),
          margin: const EdgeInsets.fromLTRB(0.0, 00.0, 0.0, 20.0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(children: [
                Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                Expanded(
                  child: Text(
                    kannadaHeading,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.blue),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}