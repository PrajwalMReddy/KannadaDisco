import 'package:flutter/material.dart';

import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/word_of_the_day.dart';
import 'package:kannada_disco/resource//resources.dart';

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("KannadaDisco Home"),
        centerTitle: true,
        backgroundColor: kannadaRed,
        elevation: 0.0,
      ),
      drawer: const SideBar(),
      body: HomeBody(size: size),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: size.height * 0.2,
            width: size.width,
            decoration: const BoxDecoration(
              color: kannadaRed,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: const WordOfTheDay(),
          ),
          const Resources(),
        ],
      ),
    );
  }
}
