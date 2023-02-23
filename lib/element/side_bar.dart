import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kannadaYellow,
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 200,
              width: 600,
              child: const Image(
                image: AssetImage("assets/splash_screen2.jpeg"), // TODO No Image For Now
              ),
            ),
            SideBarElement(page: "Usage", icon: Icons.smartphone),
            SideBarElement(page: "About", icon: Icons.info),
            SideBarElement(page: "Settings", icon: Icons.settings),
            const Divider(),
            const Center(
              child: Text(
                "Version: 0.1.0",
                style: TextStyle(
                  fontSize: 15.0,
                  color: kannadaRed,
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

  SideBarElement({
    Key? key,
    required this.page,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.red,),
      title: Text(
        page,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => {
        Navigator.pushNamed(context, '/${page.toLowerCase()}')
      },
    );
  }
}
