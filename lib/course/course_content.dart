import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/async_content.dart';
import 'package:kannada_disco/util/util.dart';

/// Shows a course lesson from `course/<heading>.md`.
class CourseContent extends StatelessWidget {
  const CourseContent({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String heading = args["heading"];

    return Scaffold(
      appBar: AppBar(
        title: Text(prettifyText(heading)),
        centerTitle: true,
        backgroundColor: kannadaBlue,
      ),
      body: AsyncContent<String>(
        future: rootBundle.loadString("course/$heading.md"),
        builder: (context, markdown) => Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
          child: Markdown(data: markdown),
        ),
      ),
    );
  }
}
