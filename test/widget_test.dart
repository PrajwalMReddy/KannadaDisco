import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kannada_disco/element/unit_card.dart';
import 'package:kannada_disco/resource/reference_entry.dart';
import 'package:kannada_disco/util/util.dart';

void main() {
  test('prettifyText turns a topic name into a title', () {
    expect(prettifyText('time_and_dates'), 'Time & Dates');
    expect(prettifyText('basic_phrases'), 'Basic Phrases');
  });

  test('wordOfDaySize shrinks long words', () {
    expect(wordOfDaySize('short'), 20.0);
    expect(wordOfDaySize('x' * 40), lessThan(20.0));
  });

  testWidgets('UnitCard shows its title and subtitle and handles taps',
      (tester) async {
    var tapped = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: UnitCard(
            title: 'Fruits', subtitle: 'ಹಣ್ಣುಗಳು', onTap: () => tapped = true),
      ),
    ));

    expect(find.text('Fruits'), findsOneWidget);
    expect(find.text('ಹಣ್ಣುಗಳು'), findsOneWidget);
    await tester.tap(find.byType(UnitCard));
    expect(tapped, isTrue);
  });

  testWidgets('ReferenceEntry shows a picture only when it has one',
      (tester) async {
    Future<void> pump(String? imagePath) => tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: ReferenceEntry(
              english: 'Mango',
              kannada: 'ಮಾವಿನ ಹಣ್ಣು',
              transliteration: 'māvina haṇṇu',
              imagePath: imagePath,
            ),
          ),
        ));

    await pump(null);
    expect(find.byType(Image), findsNothing);
    await pump('');
    expect(find.byType(Image), findsNothing);
    await pump('assets/logo.png');
    expect(find.byType(Image), findsOneWidget);
  });
}
