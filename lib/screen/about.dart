import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About KannadaDisco"),
        centerTitle: true,
        backgroundColor: kannadaBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
        child: ListView(
          shrinkWrap: true,
          children: const [
            SizedBox(height: 30,),
            Text(
                "About Kannada and Karnataka",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  // decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20,),
            Text(
              "\t\tKarnataka is a state in Southern India, and is home to over 60,000,000 people. The capital is Bangalore, which is known as the Silicon Valley of India. The primary language of Karnataka is Kannada.\n\n\t\tKannada is a Dravidian language primarily spoken by more than 45 million native speakers in the Indian state of Karnataka and the surrounding regions. It has its own script, the Kannada script, and its literary tradition stretches back over a millennia. Kannada is also recognized as a classical language of India and its literature has earned 8 Jnanpith Awards, the second highest number for any language.",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            SizedBox(height: 30,),
            Text(
                "About KannadaDisco",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  // decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20,),
            Text(
              "\t\tKannadaDisco is an all new app designed to teach the Kannada language easily and efficiently. With a wide range of features designed to make the language acquisition as effortless as possible, it aims to provide a gateway to Kannada, and even Karnataka, for people who are interested in moving here, have already moved here, or are interested in Kannada Culture.\n\n\t\tThis app teaches spoken Kannada, the way a native speaker might talk. It is important to recognize, though, that this is not standardized so different people may pronounce certain things in different ways.",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
