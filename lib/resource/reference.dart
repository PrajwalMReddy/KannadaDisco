import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/resource/reference_entry.dart';
import 'package:kannada_disco/util/util.dart';
import 'package:http/http.dart' as http;

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
    final heading = data["heading"];
    

    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: heading == null ? Text(prettifyText(topic)) : Text(heading),
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
                          "transliteration": entry["transliteration"],
                          "link" : entry["link"] ?? "NA"
                        });
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
                                    print(
                                        '${wordsData[index]["english"]}--------${wordsData[index]["kannada"]}------------${wordsData[index]["transliteration"]}');
                                    speak(wordsData[index]["kannada"]
                                        .toString()
                                        .replaceAll("___", "ಡ್ಯಾಶ್"));
                                  },
                                  child: wordsData[index]["link"].isEmpty ? SizedBox() :  ReferenceEntry(
                                      english: wordsData[index]["english"],
                                      kannada: wordsData[index]["kannada"],
                                      transliteration: wordsData[index]["transliteration"],
                                      link: wordsData[index]["link"],
                                  ),
                                );
                              },
                            );
                    }
                }
              },
            ),
          )
        : Scaffold(
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
                          "transliteration": entry["transliteration"],
                           "link" : entry["link"] ?? "NA"
                        });
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
                                    print(
                                        '${wordsData[index]["english"]}--------${wordsData[index]["kannada"]}------------${wordsData[index]["transliteration"]}');
                                    // speak(wordsData[index]["kannada"]
                                    //     .toString()
                                    //     .replaceAll("___", "ಡ್ಯಾಶ್"));

                                    getAudioApi(wordsData[index]["kannada"]
                                        .toString()
                                        .replaceAll("___", "ಡ್ಯಾಶ್"));
                                  },
                                  child: ReferenceEntry(
                                      english: wordsData[index]["english"],
                                      kannada: wordsData[index]["kannada"],
                                      transliteration: wordsData[index]
                                          ["transliteration"],
                                          link: wordsData[index]["link"],),
                                );
                              },
                            );
                    }
                }
              },
            ),
          );
  }

  final player = FlutterSoundPlayer();

  Future<void> playAudioFromBytes(Uint8List audioData) async {
    // FlutterSoundPlayer player = FlutterSoundPlayer();
    await player.openPlayer();
    await player.startPlayer(fromDataBuffer: audioData);
    // await player.stopPlayer();
  }

  Future<dynamic> getAudioApi(String text) async {
    text = text.isEmpty ? 'ಪದ ಖಾಲಿಯಾಗಿದೆ' : text;
    String url =
        'http://ivrapi.indiantts.co.in/tts?type=indiantts&text=$text.&api_key=2d108780-0b86-11e6-b056-07d516fb06e1d&user_id=80&action=play&lang=kn_dipa';
    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      // print(response.bodyBytes);
      playAudioFromBytes(response.bodyBytes);
    } catch (e) {
      print(e);
    }
  }
}
