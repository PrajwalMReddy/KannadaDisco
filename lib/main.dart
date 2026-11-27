import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/course/course_content.dart';
import 'package:kannada_disco/resource/reference.dart';
import 'package:kannada_disco/screen/about.dart';
import 'package:kannada_disco/screen/course.dart';
import 'package:kannada_disco/screen/home.dart';
import 'package:kannada_disco/screen/kids.dart';
import 'package:kannada_disco/screen/loading.dart';
import 'package:kannada_disco/screen/usage.dart';
import 'package:kannada_disco/service/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.instance.init();
  runApp(const KannadaDiscoApp());
}

class KannadaDiscoApp extends StatelessWidget {
  const KannadaDiscoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KannadaDisco',
      theme: ThemeData(
        // Keep the original Material 2 look; newer Flutter defaults to Material 3.
        useMaterial3: false,
        timePickerTheme: const TimePickerThemeData(
          helpTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: kannadaBlue),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => const Loading(),
        '/home': (context) => const Home(),
        '/usage': (context) => const Usage(),
        '/about': (context) => const About(),

        // Resources
        '/res/reading': (context) => const Reference(type: "reading"),
        '/res/vocabulary': (context) => const Reference(type: "vocab"),
        '/res/grammar': (context) => const Reference(type: "gram"),
        '/res/conversation': (context) => const Reference(type: "conv"),

        // Courses
        '/course': (context) => const CoursePage(),
        '/course/content': (context) => const CourseContent(),

        // Kids section
        '/kids': (context) => const KidsPage(),
      },
    );
  }
}
