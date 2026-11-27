import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kannada_disco/const/theme.dart';
import 'package:kannada_disco/course/course_content.dart';
import 'package:kannada_disco/screen/course.dart';
import 'package:kannada_disco/screen/home.dart';
import 'package:kannada_disco/screen/kids.dart';

/// Renders [screen] on a small phone with the given text size and theme.
/// Any overflow ("RIGHT OVERFLOWED BY ...") fails the test.
Future<void> pumpScreen(WidgetTester tester, Widget screen,
    {double textScale = 1, Brightness brightness = Brightness.light}) async {
  tester.view.physicalSize = const Size(720, 1480); // 360 x 740 dp
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(MaterialApp(
    theme: buildTheme(brightness),
    home: MediaQuery.withClampedTextScaling(
      minScaleFactor: textScale,
      maxScaleFactor: textScale,
      child: screen,
    ),
  ));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    // A cached asset from an earlier test never completes in a later one.
    rootBundle.clear();
  });

  for (final scale in [1.0, 1.5, 2.0]) {
    testWidgets('Home fits at text size $scale', (tester) async {
      await pumpScreen(tester, const Home(), textScale: scale);
      expect(tester.takeException(), isNull);
      expect(find.text('WORD OF THE DAY'), findsOneWidget);
    });

    testWidgets('Courses fit at text size $scale', (tester) async {
      await pumpScreen(tester, const CoursePage(), textScale: scale);
      expect(tester.takeException(), isNull);
      expect(find.text('Vowels & Consonants'), findsOneWidget);
    });

    testWidgets('Kids section fits at text size $scale', (tester) async {
      await pumpScreen(tester, const KidsPage(), textScale: scale);
      expect(tester.takeException(), isNull);
    });
  }

  lessonTests();

  testWidgets('Home builds in dark mode', (tester) async {
    await pumpScreen(tester, const Home(), brightness: Brightness.dark);
    expect(tester.takeException(), isNull);
  });
}

/// Opens a lesson the way the Courses tab does.
Future<void> openLesson(WidgetTester tester, String heading,
    {Brightness brightness = Brightness.light}) async {
  await tester.pumpWidget(MaterialApp(
    theme: buildTheme(brightness),
    darkTheme: buildTheme(Brightness.dark),
    themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    routes: {'/course/content': (context) => const CourseContent()},
    home: Builder(
      builder: (context) => TextButton(
        onPressed: () => Navigator.pushNamed(context, '/course/content',
            arguments: {'heading': heading}),
        child: const Text('open'),
      ),
    ),
  ));
  await tester.tap(find.text('open'));
  // Loading the lesson file is real async work; wait until the spinner goes.
  for (var i = 0; i < 50; i++) {
    await tester
        .runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump();
    if (find.byType(CircularProgressIndicator).evaluate().isEmpty) break;
  }
  // Let the page transition finish.
  await tester.pump(const Duration(seconds: 1));
  await tester.pump(const Duration(seconds: 1));
}

void lessonTests() {
  for (final brightness in Brightness.values) {
    testWidgets('A lesson with a table opens in ${brightness.name} mode',
        (tester) async {
      await openLesson(tester, 'basic_phrases', brightness: brightness);
      expect(tester.takeException(), isNull);
      expect(find.text('ನಮಸ್ಕಾರ'), findsOneWidget);
      expect(find.text('namaskāra'), findsOneWidget);
    });
  }
}
