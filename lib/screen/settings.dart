import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KannadaDisco Settings"),
        centerTitle: true,
        backgroundColor: kannadaBlue,
      ),
    );
  }
}
