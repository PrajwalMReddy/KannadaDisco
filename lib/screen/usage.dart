import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';

class Usage extends StatelessWidget {
  const Usage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Using KannadaDisco"),
        centerTitle: true,
        backgroundColor: kannadaBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
        child: ListView(
          children: const [
            SizedBox(height: 30,),
            Text(
                "Using KannadaDisco",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  // decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20,),
              Text(
              "\t\tKannadaDisco has been designed to help teach Kannada as efficiently and as easily as possible. In order to achieve this, it has been split into three main sections: the home resource library, a structured course page, and a practice section.\n\n\t\tThe resource library, which is the first thing that is seen when the app is open, is essentially a powerful dictionary. It contains references for reading Kannada, commonly used vocabulary and phrases, and even certain grammar concepts. It is meant to be used in conjunction with the Kananda courses. It allows you to easily find information in a concise form when needed, without having to scroll through all the courses, such as when you want to refer to a specific topic or when you forgot something.\n\n\t\tIn the next tab, there is the courses section. This is a structured, organized guide to learning Kannada. It introduces important topics, from the more basic concepts, while building upon previously learned concepts to help you attain conversational fluency. It is designed to teach you both grammar and vocabulary in parallel, and has plenty of examples to reinforce learning.\n\n\t\tLastly, there is the practice section, which will be introduced soon. In this section, there will be plenty of questions that correspond to topics covered in the respective course unit. A large variety of question types will be included to really reinforce all concepts covered.",
              style: TextStyle(
                fontSize: 17.0,
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
