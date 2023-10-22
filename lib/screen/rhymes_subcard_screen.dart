import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/course/course_unit.dart';
import 'package:kannada_disco/resource/reference_entry.dart';
import 'package:kannada_disco/screen/rhyme_detail_screen.dart';

class RhymesSubCardScreen extends StatelessWidget {
  String type;
  String topic;
  RhymesSubCardScreen({super.key, required this.type, required this.topic});

  Future<String> loadJson(String topic) async {
    final jsonData = await rootBundle.loadString("res/$type/$topic.json");
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rhymes'),
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
                    "name": entry["name"],
                    "kannadaName": entry["kannadaName"],
                    "description": entry["description"],
                    "english": entry["english"],
                    "kannada": entry["kannada"],
                    "transliteration": entry["transliteration"],
                    "link": entry["link"] ?? "NA"
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
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          itemCount: wordsData.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RhymeDetailScreen(
                                          name: wordsData[index]["name"],
                                          kannadaName: wordsData[index]["kannadaName"],
                                          description:  wordsData[index]["description"],
                                          english:  wordsData[index]["english"],
                                          kannada:  wordsData[index]["kannada"],
                                          transliteration:  wordsData[index]["transliteration"],
                                          link:  wordsData[index]["link"]
                                          ),
                                    ));
                              },
                              child: wordsData[index]["link"].isEmpty
                                  ? SizedBox()
                                  : CommonCard(
                                      heading: wordsData[index]["name"],
                                      kannadaHeading: wordsData[index]
                                          ["kannadaName"],
                                      topic: topic,
                                      resourceType: type),
                            );
                          },
                        ),
                      );
              }
          }
        },
      ),
    );
  }
}

class CommonCard extends StatelessWidget {
  final String heading;
  final String kannadaHeading;
  final String topic;
  final String resourceType;
  const CommonCard(
      {super.key,
      required this.heading,
      required this.kannadaHeading,
      required this.topic,
      required this.resourceType});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.22,
      width: size.width * 0.8,
      child: Card(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(100),
          topRight: Radius.circular(100),
          topLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        )),
        margin: const EdgeInsets.fromLTRB(0.0, 00.0, 0.0, 20.0),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(children: [
              Text(
                heading,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  kannadaHeading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
