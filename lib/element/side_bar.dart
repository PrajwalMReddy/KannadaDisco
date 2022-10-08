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
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(
                "About",
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              onTap: () => {
                Navigator.pushNamed(context, '/about')
              },
            ),
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
