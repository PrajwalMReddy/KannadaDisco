import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const Image(
              image: AssetImage(""), // TODO No Image For Now
            ),
            SideBarElement(page: "Usage", icon: Icons.smartphone),
            SideBarElement(page: "About", icon: Icons.info),
            SideBarElement(page: "Settings", icon: Icons.settings),
            const Divider(),
            const Center(
              child: Text(
                "Version: 0.0.0",
                style: TextStyle(
                  fontSize: 20.0,
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
      leading: Icon(icon),
      title: Text(
        page,
        style: const TextStyle(
          fontSize: 25.0,
        ),
      ),
      onTap: () => {
        Navigator.pushNamed(context, '/${page.toLowerCase()}')
      },
    );
  }
}
