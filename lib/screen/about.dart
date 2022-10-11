import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About KannadaDisco"),
        centerTitle: true,
        backgroundColor: kannadaRed,
      ),
    );
  }
}
