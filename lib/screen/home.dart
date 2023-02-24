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
    //   return  SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Container(
    //         height: size.height * 0.2,
    //         width: size.width,
    //         decoration: const BoxDecoration(
    //           color: kannadaRed,
    //           borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(30.0),
    //             bottomRight: Radius.circular(30.0),
    //           ),
    //         ),
    // child: const WordOfTheDay(),
    //       ),
    //       Resources(),
    //     ],
    //   ),
    // );

    return Stack(
      children: [
        Container(
          width: double.infinity,
          // color: kannadaRed,
          decoration: BoxDecoration(
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
          child: Column(
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
              // Container(
              //   height: ScreenSize.height! * 0.08,
              //   width: ScreenSize.width!* 0.9,
              //   child: Card(
              //     color: Colors.blue.withOpacity(0.7),
              //     child: Center(child: Text('Amma', style: TextStyle(color: Colors.white, fontSize: 20),)),
              //     elevation: 5.0,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.only(
              //         topRight: Radius.circular(40.0),
              //         bottomLeft: Radius.circular(40.0)
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: ScreenSize.height! * 0.2),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70.0),
                topRight: Radius.zero,
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(70.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Text(
                    //   'Reading & Pronounciation',
                    //   style: TextStyle(fontSize: 20),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Container(
                    //   height: ScreenSize.height! * 0.07,
                    //   width: ScreenSize.width! * 0.8,
                    //   child: Card(
                    //     child: Center(child: Text('Vowels')),
                    //     elevation: 5.0,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(30))),
                    //   ),
                    // ),
                    // Container(
                    //   height: ScreenSize.height! * 0.07,
                    //   width: ScreenSize.width! * 0.8,
                    //   child: Card(
                    //     child: Center(child: Text('Consonants')),
                    //     elevation: 5.0,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(30))),
                    //   ),
                    // ),
                    // Container(
                    //   height: ScreenSize.height! * 0.07,
                    //   width: ScreenSize.width!! * 0.8,
                    //   child: Card(
                    //     child: Center(child: Text('conjuncts')),
                    //     elevation: 5.0,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(30))),
                    //   ),
                    // ),
                    // Container(
                    //   height: ScreenSize.height! * 0.07,
                    //   width: ScreenSize.width! * 0.8,
                    //   child: Card(
                    //     child: Center(child: Text('digits')),
                    //     elevation: 5.0,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(30))),
                    //   ),
                    // ),
                    // Container(
                    //   height: ScreenSize.height! * 0.07,
                    //   width: ScreenSize.width! * 0.8,
                    //   child: Card(
                    //     child: Center(child: Text('Diacritics')),
                    //     elevation: 5.0,
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(Radius.circular(30))),
                    //   ),
                    // )
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
