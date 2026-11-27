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
import 'package:kannada_disco/element/word_tile.dart';
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
    // The app bar already shows the title. Consecutive paragraphs share one
    // card, so explanations sit in cards just like the tables.
    final items = <Object>[];
    for (final block in parseLesson(markdown)) {
      if (block is LessonTitle) continue;
      if (block is LessonParagraph) {
        if (items.isNotEmpty && items.last is List<String>) {
          (items.last as List<String>).add(block.text);
        } else {
          items.add(<String>[block.text]);
        }
      } else {
        items.add(block);
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      itemCount: items.length,
      itemBuilder: (context, index) => switch (items[index]) {
        final List<String> paragraphs => _TextCard(paragraphs),
        LessonHeading(:final text) => Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 12),
            child:
                Text(text, style: context.sectionStyle.copyWith(fontSize: 20)),
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
        _ => const SizedBox.shrink(),
      },
    );
  }
}

/// Explanation text in a card, styled like the tables: Kannada in the
/// primary colour and its pronunciation in muted italics.
class _TextCard extends StatelessWidget {
  final List<String> paragraphs;

  const _TextCard(this.paragraphs);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final base = theme.textTheme.bodyLarge!.copyWith(height: 1.5);

    TextStyle styleFor(RunKind kind) => switch (kind) {
          RunKind.plain => base,
          RunKind.bold => base.copyWith(fontWeight: FontWeight.w700),
          RunKind.kannada =>
            base.copyWith(color: scheme.primary, fontWeight: FontWeight.w600),
          RunKind.pronunciation => base.copyWith(
              color: scheme.onSurfaceVariant, fontStyle: FontStyle.italic),
        };

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (i, paragraph) in paragraphs.indexed) ...[
                if (i > 0) const SizedBox(height: 12),
                Text.rich(
                  // Kannada letters are taller than English ones; a fixed line
                  // height keeps the spacing even when lines mix both.
                  strutStyle: StrutStyle(
                    fontSize: base.fontSize,
                    height: 1.7,
                    forceStrutHeight: true,
                  ),
                  TextSpan(children: [
                    for (final run in splitRuns(paragraph))
                      TextSpan(text: run.text, style: styleFor(run.kind)),
                  ]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A list of words and phrases; tap one to hear it.
class _WordTable extends StatelessWidget {
  final List<Word> words;

  const _WordTable(this.words);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Card(
        child: Column(
          children: [
            for (final (i, word) in words.indexed) ...[
              if (i > 0) const Divider(height: 1, indent: 16, endIndent: 16),
              WordTile(
                english: word.english,
                kannada: word.kannada,
                transliteration: word.transliteration,
                card: false,
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
          return ValueListenableBuilder<String?>(
            valueListenable: Speech.speaking,
            builder: (context, speaking, _) {
              final playing = speaking == letter.kannada;
              return Card(
                color: playing ? theme.colorScheme.primaryContainer : null,
                child: InkWell(
                  onTap: () => Speech.speakWithHelp(context, letter.kannada),
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
                          style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              );
            },
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
