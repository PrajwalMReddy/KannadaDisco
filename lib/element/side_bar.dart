import 'package:flutter/material.dart';
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
              // color: kannadaBlue,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(60.0),
                  bottomLeft: Radius.circular(60.0),
                  // bottomRight: Radius.circular(30.0),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 11, 31, 48),
                      Color.fromARGB(255, 29, 66, 97),
                      //  Color.fromARGB(255, 80, 150, 207),
                      Color.fromARGB(255, 109, 161, 204),
                    ]),
              ),
              height: 200,
              width: double.infinity,
              // child: const Image(
              //   image: AssetImage("assets/splash_screen2.jpeg"), // TODO No Image For Now
              // ),
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
            // SideBarElement(page: "Settings", icon: Icons.settings),
            const Divider(),
            const Center(
              child: Text(
                "Version: 0.3.0",
                style: TextStyle(
                  fontSize: 15.0,
                  color: kannadaBlue,
                  // color: kannadaBlue,
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
  LocalNotificationService localNotificationService = LocalNotificationService();
  SideBarElement({
    Key? key,
    required this.page,
    required this.icon,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
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
      onTap: () async {
        _prefs = await SharedPreferences.getInstance();
         var time = _prefs!.getString('notificationTime') ?? "07:00:00";
         var splisttedList = time.split(':');
         int hour = int.parse(splisttedList[0]);
         int minute = int.parse(splisttedList[1]);
        if (page == "Settings") {
          pickedTime = await showTimePicker(
            helpText: "Set Notification Time",
            initialTime: TimeOfDay(hour: hour, minute: minute),
            context: context,
          );
          if (pickedTime != null) {
            print(pickedTime!.format(context)); //output 10:51 PM
            DateTime parsedTime =
                DateFormat.jm().parse(pickedTime!.format(context).toString());
            //converting to DateTime so that we can further format on different pattern.
            print(parsedTime); //output 1970-01-01 22:53:00.000
            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime); 
            print(formattedTime); //output 14:59:00 
            _prefs!.setString('notificationTime', formattedTime);
            localNotificationService.scheduleDailyNotification();
            // _prefs!.setString('lastDate', DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1))));
            //DateFormat() is from intl package, you can format the time on any pattern you need.
          } else {
            print("Time is not selected");
          }
        } else {
          Navigator.pushNamed(context, '/${page.toLowerCase()}');
        }
      },
    );
  }
}
