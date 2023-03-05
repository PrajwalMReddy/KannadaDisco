import 'package:flutter/material.dart';

class ReferenceEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  const ReferenceEntry({Key? key, required this.english, required this.kannada, required this.transliteration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  english,
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.end,
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
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
