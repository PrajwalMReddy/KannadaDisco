import 'package:flutter/material.dart';

class WordEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  const WordEntry({Key? key, required this.english, required this.kannada, required this.transliteration}) : super(key: key);

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
