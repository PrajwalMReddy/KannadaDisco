/// Splits a course lesson (`course/*.md`) into blocks the app can draw in its
/// own style, so the lessons stay plain markdown files.
///
/// Lessons use `#` for the title, `##` for section headings, `###` (or plain
/// lines) for explanations, and tables. Tables with English / Kannada /
/// Transliteration columns become [WordTable]s, and Vowel or Consonant /
/// Symbol / Pronunciation tables become [LetterTable]s. Any other table is
/// kept as markdown in an [OtherTable].
library;

sealed class LessonBlock {
  const LessonBlock();
}

class LessonTitle extends LessonBlock {
  final String text;
  const LessonTitle(this.text);
}

class LessonHeading extends LessonBlock {
  final String text;
  const LessonHeading(this.text);
}

/// Explanation text. May contain inline markdown such as **bold**.
class LessonParagraph extends LessonBlock {
  final String text;
  const LessonParagraph(this.text);
}

typedef Word = ({String english, String kannada, String transliteration});

class WordTable extends LessonBlock {
  final List<Word> words;
  const WordTable(this.words);
}

typedef Letter = ({String latin, String kannada, String pronunciation});

class LetterTable extends LessonBlock {
  final List<Letter> letters;
  const LetterTable(this.letters);
}

class OtherTable extends LessonBlock {
  final String markdown;
  const OtherTable(this.markdown);
}

List<LessonBlock> parseLesson(String markdown) {
  final lines = markdown.replaceAll('\r\n', '\n').split('\n');
  final blocks = <LessonBlock>[];
  final paragraph = <String>[];

  void endParagraph() {
    if (paragraph.isEmpty) return;
    blocks.add(LessonParagraph(paragraph.join(' ')));
    paragraph.clear();
  }

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    if (line.startsWith('|')) {
      endParagraph();
      final table = <String>[];
      while (i < lines.length && lines[i].trim().startsWith('|')) {
        table.add(lines[i].trim());
        i++;
      }
      i--;
      blocks.add(_parseTable(table));
    } else if (line.isEmpty) {
      endParagraph();
    } else if (line.startsWith('### ')) {
      // Lessons use ### for explanation text, one paragraph per line.
      endParagraph();
      blocks.add(LessonParagraph(line.substring(4).trim()));
    } else if (line.startsWith('## ')) {
      endParagraph();
      blocks.add(LessonHeading(line.substring(3).trim()));
    } else if (line.startsWith('# ')) {
      endParagraph();
      blocks.add(LessonTitle(line.substring(2).trim()));
    } else {
      paragraph.add(line);
    }
  }
  endParagraph();
  return blocks;
}

List<String> _cells(String row) {
  var inner = row.trim();
  if (inner.startsWith('|')) inner = inner.substring(1);
  if (inner.endsWith('|')) inner = inner.substring(0, inner.length - 1);
  return inner.split('|').map((c) => c.trim()).toList();
}

bool _isSeparator(String row) =>
    _cells(row).every((c) => RegExp(r'^:?-+:?$').hasMatch(c));

LessonBlock _parseTable(List<String> rows) {
  if (rows.length < 2 || !_isSeparator(rows[1])) {
    return OtherTable(rows.join('\n'));
  }
  final header = _cells(rows[0]).map((c) => c.toLowerCase()).toList();
  final body =
      rows.skip(2).map(_cells).where((r) => r.length == header.length).toList();

  if (header.length == 3 &&
      header[0] == 'english' &&
      header[1] == 'kannada' &&
      header[2] == 'transliteration') {
    return WordTable([
      for (final r in body)
        (english: r[0], kannada: r[1], transliteration: r[2]),
    ]);
  }
  if (header.length == 3 &&
      (header[0] == 'vowel' || header[0] == 'consonant') &&
      header[1] == 'symbol' &&
      header[2] == 'pronunciation') {
    return LetterTable([
      for (final r in body) (latin: r[0], kannada: r[1], pronunciation: r[2]),
    ]);
  }
  return OtherTable(rows.join('\n'));
}

/// How a piece of explanation text is shown.
enum RunKind { plain, bold, kannada, pronunciation }

typedef TextRun = ({String text, RunKind kind});

// **bold**, or Kannada words (several in a row count as one) optionally
// followed by their pronunciation in brackets, e.g. "ಅವರು (avaru)".
final _runPattern = RegExp(
  r'\*\*(.+?)\*\*'
  r'|([ಀ-೿][ಀ-೿‌‍]*'
  r'(?:\s+[ಀ-೿][ಀ-೿‌‍]*)*)'
  r'(\s*\([^()]*\))?',
);

/// Splits explanation text so Kannada and its pronunciation can be styled
/// like the word tables.
List<TextRun> splitRuns(String text) {
  final runs = <TextRun>[];
  var at = 0;
  for (final m in _runPattern.allMatches(text)) {
    if (m.start > at) {
      runs.add((text: text.substring(at, m.start), kind: RunKind.plain));
    }
    if (m.group(1) != null) {
      runs.add((text: m.group(1)!, kind: RunKind.bold));
    } else {
      runs.add((text: m.group(2)!, kind: RunKind.kannada));
      if (m.group(3) != null) {
        runs.add((text: m.group(3)!, kind: RunKind.pronunciation));
      }
    }
    at = m.end;
  }
  if (at < text.length) {
    runs.add((text: text.substring(at), kind: RunKind.plain));
  }
  return runs;
}
