import 'package:flutter/material.dart';

import 'package:kannada_disco/const/color.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kannadaRed,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage(""), // TODO No Image For Now
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              "KannadaDisco",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
