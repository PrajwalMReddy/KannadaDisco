import 'package:flutter/material.dart';

class VocabularyEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  const VocabularyEntry({Key? key, required this.english, required this.kannada, required this.transliteration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  "$kannada - $transliteration",
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

class GrammarEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  const GrammarEntry({Key? key, required this.english, required this.kannada, required this.transliteration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Text(
                  english,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      kannada,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      transliteration,
                      style: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

