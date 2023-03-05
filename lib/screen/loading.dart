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
    Future.delayed(Duration(seconds: 3), () {
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
      body: Container(
        decoration: const BoxDecoration(
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
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image(
              //   image: AssetImage(""), // TODO No Image For Now
              // ),
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "To",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
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
              SizedBox(
                height: 20.0,
              ),
              Text(
                "ಕನ್ನಡ ಡಿಸ್ಕೋ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
