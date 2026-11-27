import 'package:material_ui/material_ui.dart';
import 'package:kannada_disco/const/color.dart';

class Usage extends StatelessWidget {
  const Usage({super.key});

  static const _heading =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: kannadaSeed);
  static const _body = TextStyle(fontSize: 17, height: 1.45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Using KannadaDisco")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
        child: ListView(
          children: const [
            SizedBox(height: 30),
            Text(
              "Using KannadaDisco\nಕನ್ನಡ ಡಿಸ್ಕೋ ಬಳಸುವ ರೀತಿ",
              style: _heading,
            ),
            SizedBox(height: 20),
            Text(
              "KannadaDisco has been designed to help teach Kannada as efficiently and as easily as possible. In order to achieve this, it has been split into three main sections: the home resource library, a structured course page, and a practice section.\n\n"
              "The resource library, which is the first thing that is seen when the app is open, is essentially a powerful dictionary. It contains references for reading Kannada, commonly used vocabulary and phrases, and even certain grammar concepts. It is meant to be used in conjunction with the Kannada courses. It allows you to easily find information in a concise form when needed, without having to scroll through all the courses, such as when you want to refer to a specific topic or when you forgot something.\n\n"
              "In the next tab, there is the courses section. This is a structured, organized guide to learning Kannada. It introduces important topics, from the more basic concepts, while building upon previously learned concepts to help you attain conversational fluency. It is designed to teach you both grammar and vocabulary in parallel, and has plenty of examples to reinforce learning.\n\n"
              "Lastly, there is the practice section, which will be introduced soon. In this section, there will be plenty of questions that correspond to topics covered in the respective course unit. A large variety of question types will be included to really reinforce all concepts covered.",
              style: _body,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
