import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kannada_disco/util/util.dart';
import 'package:kannada_disco/const/color.dart';

class CourseContent extends StatelessWidget {
  String heading = "";
  String markdownData = "";

  CourseContent({Key? key}) : super(key: key);

  Future<String> loadMarkdown(String heading) async {
    final data = await rootBundle.loadString("course/$heading.md");
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final heading = data["heading"];

    return Scaffold(
      appBar: AppBar(
        title: Text(prettifyText(heading)),
        centerTitle: true,
        backgroundColor: kannadaBlue,
      ),
      body: FutureBuilder<String>(
        future: loadMarkdown(heading),
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
                String markdownData = snapshot.data ?? "";

                return Container(
                  margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                  child: Markdown(
                    data: markdownData,
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

