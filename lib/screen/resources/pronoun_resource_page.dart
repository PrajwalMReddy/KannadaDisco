import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class PronounResourcePage extends StatelessWidget {
  const PronounResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pronouns"),
        centerTitle: true,
        backgroundColor: kannadaRed,
      ),
      body: Column(
        children: const [
          WordPair(english: "I", kannada: "ನಾನು", transliteration: "naanu",),
          WordPair(english: "You (Singular)", kannada: "ನೀನು", transliteration: "neenu",),
          WordPair(english: "He", kannada: "ಅವನು", transliteration: "avanu",),
          WordPair(english: "She", kannada: "ಅವಳು", transliteration: "avaLu",),
        ],
      ),
    );
  }
}

class WordPair extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  const WordPair({Key? key, required this.english, required this.kannada, required this.transliteration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(
                  english,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const Spacer(),
                Text(
                  kannada + " - " + transliteration,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
