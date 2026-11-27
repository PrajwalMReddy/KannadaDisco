import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:kannada_disco/const/course_units.dart';
import 'package:kannada_disco/const/resource_topic.dart';

/// Same mapping as the routes in main.dart.
const _folderForType = {
  "reading": "reading",
  "vocabulary": "vocab",
  "grammar": "gram",
  "conversation": "conv",
};

void main() {
  test('every course unit has a lesson file', () {
    for (final unit in allCourseCards) {
      expect(File('course/${unit.heading}.md').existsSync(), isTrue,
          reason: 'missing course/${unit.heading}.md');
    }
  });

  test('every resource and kids topic has a JSON file', () {
    final topics = [
      for (final card in [
        ...readingCards,
        ...vocabCards,
        ...grammarCards,
        ...conversationCards,
      ])
        (card.resourceType, card.topic),
      for (final unit in grade1_2cards) (unit.resourceType, unit.topic),
      for (final unit in conversationSubCards) (unit.resourceType, unit.topic),
    ];

    for (final (type, topic) in topics) {
      final path = 'res/${_folderForType[type]}/$topic.json';
      expect(File(path).existsSync(), isTrue, reason: 'missing $path');
    }
  });

  test('every JSON file parses and its pictures exist', () {
    final files = Directory('res')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.json'));
    expect(files, isNotEmpty);

    for (final file in files) {
      final data = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      for (final entry in data.values.cast<Map<String, dynamic>>()) {
        final link = entry['link'] as String?;
        // Rhymes use "link" for a YouTube video ID, not a picture.
        if (link != null && link.startsWith('assets/')) {
          expect(File(link).existsSync(), isTrue,
              reason: '${file.path} points to missing picture $link');
        }
      }
    }
  });
}
