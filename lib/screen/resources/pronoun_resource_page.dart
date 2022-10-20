import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class PronounResourcePage extends StatelessWidget {
  const PronounResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pronouns"),
        centerTitle: true,
        backgroundColor: kannadaRed,
      ),
    );
  }
}
