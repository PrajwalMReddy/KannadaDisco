import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/service/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(60.0),
                  bottomLeft: Radius.circular(60.0),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 11, 31, 48),
                      Color.fromARGB(255, 29, 66, 97),
                      Color.fromARGB(255, 109, 161, 204),
                    ]),
              ),
              height: 200,
              width: double.infinity,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "KannadaDisco",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "ಕನ್ನಡ ಡಿಸ್ಕೋ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SideBarElement(page: "About", icon: Icons.info),
            SideBarElement(page: "Usage", icon: Icons.smartphone),
            SideBarElement(page: "Settings", icon: Icons.settings),
            const Divider(),
            const Center(
              child: Text(
                "Version: 0.5.0",
                style: TextStyle(
                  fontSize: 15.0,
                  color: kannadaBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBarElement extends StatelessWidget {
  String page;
  IconData icon;
  SharedPreferences? _prefs;
  TimeOfDay? pickedTime;
  LocalNotificationService localNotificationService =
      LocalNotificationService();
  SideBarElement({
    Key? key,
    required this.page,
    required this.icon,
  }) : super(key: key);

  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return ListTile(
      leading: Icon(
        icon,
        color: kannadaBlue,
      ),
      title: Text(
        page,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => _onClickSidebarElement(),
    );
  }

  void _onClickSidebarElement() async {
    if (page == "Settings") {
      _displayTextInputDialog(ctx!);
    } else {
      Navigator.pushNamed(ctx!, '/${page.toLowerCase()}');
    }
  }

  TextEditingController hourController = TextEditingController();
  TextEditingController minuteController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    _prefs = await SharedPreferences.getInstance();
    var time = _prefs!.getString('notificationTime') ?? "07:00:00";
    var splittedTime = time.split(':');
    hourController.text = splittedTime[0];
    minuteController.text = splittedTime[1];
    return showDialog(
      context: ctx!,
      builder: (context) {
        return AlertDialog(
          title: const Column(
            children: [
              Text('Set Notification Time'),
              SizedBox(
                height: 5,
              ),
              Text(
                '( 24h format )',
                style: TextStyle(
                    color: Color.fromARGB(255, 42, 41, 41), fontSize: 12),
              )
            ],
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  width: 55,
                  // height: 30,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'hh',
                      border: OutlineInputBorder(),
                      labelText: 'hh',
                    ),
                    controller: hourController,
                    // decoration: InputDecoration(hintText: "e.g. 07:00:00"),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(':'),
              ),
              Flexible(
                child: SizedBox(
                  width: 55,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'mm',
                      border: OutlineInputBorder(),
                      labelText: 'mm',
                    ),
                    controller: minuteController,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              color: kannadaBlue,
              textColor: Colors.white,
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              width: 70,
            ),
            MaterialButton(
              color: kannadaBlue,
              textColor: Colors.white,
              child: const Text('OK'),
              onPressed: () {
                try {
                  String time =
                      "${hourController.text}:${minuteController.text}:00";
                  print(time);
                  _prefs!.setString('notificationTime', time);
                  localNotificationService
                      .scheduleDailyNotification()
                      .then((value) {
                    if (value) {
                      Fluttertoast.showToast(
                        msg:
                            "Notification time has been set to ${hourController.text}:${minuteController.text} successfully!",
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  });
                  Navigator.pop(context);
                } catch (e) {
                  print("Invalid Time Format");
                }
              },
            ),
          ],
        );
      },
    );
  }
}
