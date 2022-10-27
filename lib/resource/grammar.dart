import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/word_entry.dart';
import 'package:kannada_disco/util/util.dart';

class Grammar extends StatelessWidget {
  Map<String, dynamic> topicData = {};

  Grammar({Key? key}) : super(key: key);

  Future<String> loadJson(String topic) async {
    final jsonData = await rootBundle.loadString("res/gram/$topic.json");
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final topic = data["topic"];

    return Scaffold(
      appBar: AppBar(
        title: Text(prettifyTopic(topic)),
        centerTitle: true,
        backgroundColor: kannadaRed,
      ),
      body: FutureBuilder<String>(
        future: loadJson(topic),
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
                List<Widget> wordsData = [];

                for (var entry in mapData.values) {
                  wordsData.add(
                      WordEntry(english: entry["english"], kannada: entry["kannada"], transliteration: entry["transliteration"])
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: wordsData,
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
