import 'package:flutter/material.dart';

class ReferenceEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  const ReferenceEntry({Key? key, required this.english, required this.kannada, required this.transliteration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 10.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  english,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
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
