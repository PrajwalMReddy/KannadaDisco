// Only for lessonStyle below.
// ignore: deprecated_member_use
import 'package:flutter/material.dart' as fm;
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/const/theme.dart';
import 'package:kannada_disco/course/lesson_parser.dart';
import 'package:kannada_disco/element/async_content.dart';
import 'package:kannada_disco/util/speech.dart';
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
        builder: (context, markdown) => LessonView(markdown: markdown),
      ),
    );
  }
}

/// Draws a lesson's blocks in the app's style.
class LessonView extends StatelessWidget {
  final String markdown;

  const LessonView({super.key, required this.markdown});

  @override
  Widget build(BuildContext context) {
    // The app bar already shows the title.
    final blocks =
        parseLesson(markdown).where((b) => b is! LessonTitle).toList();

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      itemCount: blocks.length,
      itemBuilder: (context, index) => switch (blocks[index]) {
        LessonTitle() => const SizedBox.shrink(),
        LessonHeading(:final text) => Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child:
                Text(text, style: context.sectionStyle.copyWith(fontSize: 20)),
          ),
        LessonParagraph(:final text) => Padding(
            padding: const EdgeInsets.only(top: 12),
            child: MarkdownBody(
              data: text,
              styleSheet: lessonStyle(Theme.of(context).brightness),
            ),
          ),
        WordTable(:final words) => _WordTable(words),
        LetterTable(:final letters) => _LetterGrid(letters),
        OtherTable(markdown: final table) => Padding(
            padding: const EdgeInsets.only(top: 12),
            child: MarkdownBody(
              data: table,
              styleSheet: lessonStyle(Theme.of(context).brightness),
            ),
          ),
      },
    );
  }
}

/// A list of words and phrases; tap one to hear it.
class _WordTable extends StatelessWidget {
  final List<Word> words;

  const _WordTable(this.words);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Card(
        child: Column(
          children: [
            for (final (i, word) in words.indexed) ...[
              if (i > 0) const Divider(height: 1, indent: 16, endIndent: 16),
              InkWell(
                onTap: () => Speech.speak(word.kannada),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(word.english,
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: muted)),
                            const SizedBox(height: 2),
                            Text(word.kannada, style: context.kannadaStyle),
                            Text(word.transliteration,
                                style: theme.textTheme.bodyLarge),
                          ],
                        ),
                      ),
                      Icon(Icons.volume_up_rounded,
                          color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Letters of the script as tiles; tap one to hear it.
class _LetterGrid extends StatelessWidget {
  final List<Letter> letters;

  const _LetterGrid(this.letters);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = MediaQuery.textScalerOf(context).scale(1);

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 96,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: 100 * scale,
        ),
        itemCount: letters.length,
        itemBuilder: (context, index) {
          final letter = letters[index];
          return Card(
            child: InkWell(
              onTap: () => Speech.speak(letter.kannada),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(letter.kannada,
                      style: theme.textTheme.headlineMedium!.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600)),
                  Text(letter.latin,
                      style: theme.textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w600)),
                  Text(letter.pronunciation,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Style for the markdown parts of a lesson (explanation text and any table
/// that isn't a word or letter table).
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
    p: text.bodyLarge!.copyWith(height: 1.5),
    tableHead: text.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
    tableBody: text.bodyMedium,
    tableCellsPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    tableColumnWidth: const FlexColumnWidth(),
    tableBorder: TableBorder.all(color: theme.colorScheme.outlineVariant),
    tableHeadAlign: TextAlign.center,
  );
}
