import 'package:flutter/material.dart';
import 'package:kannada_disco/element/side_bar.dart';
import 'package:kannada_disco/element/bottom_navigation.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/word_of_the_day.dart';
import 'package:kannada_disco/resource/resources.dart';
import 'package:kannada_disco/service/local_notification_service.dart';
import 'package:kannada_disco/util/screen_size.dart';
import 'package:notification_permissions/notification_permissions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LocalNotificationService localNotificationService = LocalNotificationService();
  Future<bool> getCheckNotificationPermStatus() {
    return NotificationPermissions.getNotificationPermissionStatus().then((status) {
      switch (status) {
        case PermissionStatus.denied:
          return false;
        case PermissionStatus.granted:
          return true;
        case PermissionStatus.unknown:
          return false;
        default:
          return false;
      }
    });
  }

  requestPermission() async {
    await NotificationPermissions.requestNotificationPermissions();
    getCheckNotificationPermStatus().then((status) {
      if (status) {
        localNotificationService.scheduleDailyNotification();
      }
    });
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

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
        backgroundColor: kannadaBlue,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: const [
                SizedBox(
                  height: 20,
                ),
                WordOfTheDay(),
              ],
            ),
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
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: const [
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
