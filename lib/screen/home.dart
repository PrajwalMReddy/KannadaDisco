import 'package:flutter/material.dart';

import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/const/color.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KannadaDisco"),
        centerTitle: true,
        backgroundColor: kannadaRed,
      ),
      drawer: const SideBar(),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
