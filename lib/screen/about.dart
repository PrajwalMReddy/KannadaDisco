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
            SizedBox(height: 30),
            Text(
              "About Kannada and Karnataka\nಕನ್ನಡ ಮತ್ತು ಕರ್ನಾಟಕದ ಬಗ್ಗೆ",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Karnataka is a state in Southern India, and is home to over 60,000,000 people. The capital is Bangalore, which is known as the Silicon Valley of India. The primary language of Karnataka is Kannada.\n\nKannada is a Dravidian language primarily spoken by more than 45 million native speakers in the Indian state of Karnataka and the surrounding regions. It has its own script, the Kannada script, and its literary tradition stretches back over a millennia. Kannada is also recognized as a classical language of India and its literature has earned 8 Jnanpith Awards, the second highest number for any language.",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "About KannadaDisco\nಕನ್ನಡ ಡಿಸ್ಕೋ ಬಗ್ಗೆ",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "KannadaDisco is an all new app designed to teach the Kannada language easily and efficiently. With a wide range of features designed to make the language acquisition as effortless as possible, it aims to provide a gateway to Kannada, and even Karnataka, for people who are interested in moving here, have already moved here, or are interested in Kannada Culture."
                  "\n\nThis app teaches spoken Kannada, the way a native speaker might talk, and assumes no prior knowledge of the language. It is important to recognize, though, that this is not standardized so different people may pronounce certain things in different ways."
                  "\n\nIt is important to note, though, that this guide is not comprehensive in that it cannot teach every single feature of Kannada. However, it focuses on teaching spoken Kannada, the way a native speaker may speak, rather than the written language helping you better in your daily life.",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
