// Only for lessonStyle below.
// ignore: deprecated_member_use
import 'package:flutter/material.dart' as fm;
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
      appBar: AppBar(title: Text(prettifyText(heading))),
      body: AsyncContent<String>(
        future: rootBundle.loadString("course/$heading.md"),
        builder: (context, markdown) => Markdown(
          data: markdown,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          styleSheet: lessonStyle(Theme.of(context).brightness),
        ),
      ),
    );
  }
}

/// Lesson text, with tables that fit a phone: the three columns share the
/// width, and tighter cells stop headers like "Transliteration" breaking
/// mid-word.
///
/// flutter_markdown_plus still uses Flutter's built-in Material classes, not
/// material_ui, so it can't read the app theme. Build its styles from the
/// same seed colour instead, so lessons match the app in light and dark.
MarkdownStyleSheet lessonStyle(Brightness brightness) {
  final base =
      fm.ThemeData(brightness: brightness, colorSchemeSeed: kannadaSeed);
  // A bare ThemeData has no font sizes until Theme.of resolves it, and
  // fromTheme needs them, so apply them here.
  final theme = fm.ThemeData.localize(base, base.typography.englishLike);
  final text = theme.textTheme;
  return MarkdownStyleSheet.fromTheme(theme).copyWith(
    p: text.bodyLarge,
    h1: text.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
    h2: text.titleLarge!.copyWith(fontWeight: FontWeight.w700),
    h3: text.titleMedium!.copyWith(fontWeight: FontWeight.w700),
    tableHead: text.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
    tableBody: text.bodyMedium,
    tableCellsPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    tableColumnWidth: const FlexColumnWidth(),
    tableBorder: TableBorder.all(color: theme.colorScheme.outlineVariant),
    tableHeadAlign: TextAlign.center,
  );
}
