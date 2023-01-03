import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kannada_disco/const/resource_topic.dart';
import 'package:kannada_disco/util/util.dart';

class WordOfTheDay extends StatelessWidget {
  const WordOfTheDay({
    Key? key,
  }) : super(key: key);

  Future<String> randomWord() async {
    final word = (vocabCards.toList()..shuffle()).first;
    final jsonData = await rootBundle.loadString("res/vocab/${word.topic}.json");
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    "Word Of The Day",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  FutureBuilder<String>(
                    future: randomWord(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const Text("Loading...");
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error: ${snapshot.error}"),
                            );
                          } else {
                            String jsonData = snapshot.data ?? "";
                            final Map<String, dynamic> mapData = jsonDecode(jsonData);
                            List wordsData = [];

                            for (var entry in mapData.values) {
                              wordsData.add(entry);
                            }

                            final word = (wordsData..shuffle()).first;
                            String english = word["english"];
                            String kannada = word["kannada"];
                            String transliteration = word["transliteration"];
                            final info = "$kannada - $transliteration - $english";

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                                  child: Text(
                                    info,
                                    style: TextStyle(
                                      fontSize: wordOfDaySize(info),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
