import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/resource/reference_entry.dart';
import 'package:kannada_disco/util/util.dart';

class Reference extends StatelessWidget {
  String type;
  Map<String, dynamic> topicData = {};

  Reference({Key? key, required this.type}) : super(key: key);

  Future<String> loadJson(String topic) async {
    final jsonData = await rootBundle.loadString("res/$type/$topic.json");
    return jsonData;
  }

  final FlutterTts flutterTts = FlutterTts();

  speak(String text) async {
    await flutterTts.setLanguage("kn-IN");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final topic = data["topic"];

    return Scaffold(
      appBar: AppBar(
        title: Text(prettifyText(topic)),
        centerTitle: true,
        backgroundColor: kannadaBlue,
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
                List wordsData = [];

                for (var entry in mapData.values) {
                  wordsData.add({
                      "english": entry["english"],
                      "kannada": entry["kannada"],
                      "transliteration": entry["transliteration"]});
                }

                return (wordsData.isEmpty)
                    ? Center(
                        child: SizedBox(
                          height: 150,
                          width: 300,
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: const Center(
                              child: Text(
                                'To be added...',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                      itemCount: wordsData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print('${wordsData[index]["english"]}--------${wordsData[index]["kannada"]}------------${wordsData[index]["transliteration"]}');
                            speak(wordsData[index]["kannada"].toString().replaceAll("___", "ಡ್ಯಾಶ್"));
                          },
                          child: ReferenceEntry(
                                              english: wordsData[index]["english"],
                                              kannada: wordsData[index]["kannada"],
                                              transliteration: wordsData[index]["transliteration"]),
                        );
                      },
                      );
              }
          }
        },
      ),
    );
  }
}
