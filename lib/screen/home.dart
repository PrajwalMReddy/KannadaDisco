import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/element/word_of_the_day.dart';
import 'package:kannada_disco/resource/resources.dart';
import 'package:kannada_disco/service/notification_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _setUpReminder();
  }

  Future<void> _setUpReminder() async {
    final service = NotificationService.instance;
    if (await service.requestPermission()) {
      await service.scheduleDailyNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "KannadaDisco",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: kannadaBlue,
        elevation: 0.0,
      ),
      drawer: const SideBar(),
      body: const HomeBody(),
      bottomNavigationBar: const BottomNavigation(currentPage: 0),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 11, 31, 48),
                Color.fromARGB(255, 55, 110, 155),
                Color.fromARGB(255, 80, 150, 207),
                Color.fromARGB(255, 109, 161, 204),
              ],
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(children: [WordOfTheDay()]),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.2),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70.0),
                bottomRight: Radius.circular(70.0),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(child: Resources()),
            ),
          ),
        ),
      ],
    );
  }
}
