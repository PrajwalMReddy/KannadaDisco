import 'package:flutter/material.dart';
import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/word_of_the_day.dart';
import 'package:kannada_disco/resource//resources.dart';
import 'package:kannada_disco/util/screen_size.dart';

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
    ScreenSize.height = size.height;
    ScreenSize.width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "KannadaDisco",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: kannadaRed,
        elevation: 0.0,
      ),
      drawer: const SideBar(),
      body: HomeBody(size: size),
      bottomNavigationBar: BottomNavigation(currentPage: 0),
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
    return Stack(
      children: [
        Container(
          width: double.infinity,
          // color: kannadaRed,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 11, 31, 48),
                   Color.fromARGB(255, 55, 110, 155),
                   Color.fromARGB(255, 80, 150, 207),
                  Color.fromARGB(255, 109, 161, 204),
                ]),
          ),
          child: const Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Word',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                'of the day',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              WordOfTheDay(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenSize.height! * 0.2),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70.0),
                topRight: Radius.zero,
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(70.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Resources(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
