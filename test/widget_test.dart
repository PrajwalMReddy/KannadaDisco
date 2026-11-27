import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/element/unit_card.dart';
import 'package:kannada_disco/resource/reference_entry.dart';
import 'package:kannada_disco/screen/settings.dart';
import 'package:kannada_disco/util/util.dart';

void main() {
  test('prettifyText turns a topic name into a title', () {
    expect(prettifyText('time_and_dates'), 'Time & Dates');
    expect(prettifyText('basic_phrases'), 'Basic Phrases');
  });

  test('splitWordOfDay separates the three parts', () {
    final word = splitWordOfDay('ನಮಸ್ಕಾರ - namaskāra - hello');
    expect(word.kannada, 'ನಮಸ್ಕಾರ');
    expect(word.transliteration, 'namaskāra');
    expect(word.english, 'hello');

    final odd = splitWordOfDay('just one part');
    expect(odd.kannada, 'just one part');
    expect(odd.english, '');
  });

  test('Feedback never points iOS users at Google Play', () {
    expect(feedbackUrl(TargetPlatform.android), contains('play.google.com'));
    final ios = feedbackUrl(TargetPlatform.iOS);
    if (appStoreId.isEmpty) {
      expect(ios, isNull);
    } else {
      expect(ios, contains('apps.apple.com'));
    }
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

  testWidgets('Reminder time sheet returns a preset time', (tester) async {
    TimeOfDay? picked;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => TextButton(
            onPressed: () async => picked = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const ReminderTimeSheet(
                  initial: TimeOfDay(hour: 7, minute: 3)),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    // 7:03 shows as 7:00, since minutes go in steps of 5.
    expect(find.text('Remind me at 7:00 AM'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, '6:00 PM'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remind me at 6:00 PM'));
    await tester.pumpAndSettle();
    expect(picked, const TimeOfDay(hour: 18, minute: 0));
  });
}
