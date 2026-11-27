import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:kannada_disco/course/lesson_parser.dart';

void main() {
  test('splits a lesson into title, text, headings and tables', () {
    final blocks = parseLesson('''
# Genitive Case

### Cases are suffixes.

## Singular Pronouns

| English | Kannada | Transliteration |
|:-------:|:-------:|:---------------:|
|   My    |  ನನ್ನ   |      nanna      |
|  Your   |  ನಿನ್ನ  |      ninna      |

## Vowels

| Vowel | Symbol | Pronunciation |
|:-----:|:------:|:-------------:|
|   a   |   ಅ    |      [a]      |

| A | B |
|---|---|
| 1 | 2 |
''');

    expect(blocks.map((b) => b.runtimeType), [
      LessonTitle,
      LessonParagraph,
      LessonHeading,
      WordTable,
      LessonHeading,
      LetterTable,
      OtherTable,
    ]);
    final words = (blocks[3] as WordTable).words;
    expect(words, hasLength(2));
    expect(words.first,
        (english: 'My', kannada: 'ನನ್ನ', transliteration: 'nanna'));
    expect((blocks[5] as LetterTable).letters.single.kannada, 'ಅ');
  });

  test('every course lesson is fully understood', () {
    for (final file in Directory('course').listSync().whereType<File>()) {
      final text = file.readAsStringSync();
      final blocks = parseLesson(text);
      final tableRows =
          RegExp(r'^\s*\|', multiLine: true).allMatches(text).length;
      var parsedRows = 0;
      for (final b in blocks) {
        expect(b, isNot(isA<OtherTable>()),
            reason: '${file.path} has a table the app shows as plain markdown');
        if (b is WordTable) parsedRows += b.words.length + 2;
        if (b is LetterTable) parsedRows += b.letters.length + 2;
      }
      expect(parsedRows, tableRows,
          reason: '${file.path}: some table rows were dropped');
    }
  });

  test('explanation text marks Kannada and its pronunciation', () {
    final runs = splitRuns(
        'For example, ಅವರು (avaru) means ‘those people’ and **this** is ಆ.');
    expect(runs, [
      (text: 'For example, ', kind: RunKind.plain),
      (text: 'ಅವರು', kind: RunKind.kannada),
      (text: ' (avaru)', kind: RunKind.pronunciation),
      (text: ' means ‘those people’ and ', kind: RunKind.plain),
      (text: 'this', kind: RunKind.bold),
      (text: ' is ', kind: RunKind.plain),
      (text: 'ಆ', kind: RunKind.kannada),
      (text: '.', kind: RunKind.plain),
    ]);
  });

  test('multi-word Kannada stays together', () {
    final runs = splitRuns('ನನ್ನ ಪುಸ್ತಕ (nanna pustaka) means my book');
    expect(runs.first, (text: 'ನನ್ನ ಪುಸ್ತಕ', kind: RunKind.kannada));
    expect(runs[1], (text: ' (nanna pustaka)', kind: RunKind.pronunciation));
  });

  test('brackets after English are left alone', () {
    expect(splitRuns('How are you? (Informal)'),
        [(text: 'How are you? (Informal)', kind: RunKind.plain)]);
  });
}
