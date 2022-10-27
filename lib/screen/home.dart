import 'package:flutter/material.dart';

import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/element/resource_card.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/const/resource_topic.dart';

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
        title: const Text("KannadaDisco"),
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
    return Column(
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
        const Resources()
      ],
    );
  }
}

// TODO Finish The Word Of The Day Card
class WordOfTheDay extends StatelessWidget {
  const WordOfTheDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Word Of The Day",
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Resources extends StatelessWidget {
  const Resources({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: const [
            ResourceGrid(type: "Vocabulary", cards: vocabCards),
            ResourceGrid(type: "Grammar", cards: gramCards),
          ],
        ),
      ),
    );
  }
}

class ResourceGrid extends StatelessWidget {
  const ResourceGrid({
    Key? key,
    required this.type,
    required this.cards,
  }) : super(key: key);

  final String type;
  final List<ResourceCard> cards;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          type,
          style: const TextStyle(
            fontSize: 20.0,
            decoration: TextDecoration.underline,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: cards,
          ),
        ),
      ],
    );
  }
}
