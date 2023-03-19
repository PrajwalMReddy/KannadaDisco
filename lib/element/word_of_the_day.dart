import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kannada_disco/const/resource_topic.dart';
import 'package:kannada_disco/util/screen_size.dart';
import 'package:kannada_disco/util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordOfTheDay extends StatefulWidget {
  const WordOfTheDay({
    Key? key,
  }) : super(key: key);

  @override
  State<WordOfTheDay> createState() => _WordOfTheDayState();
}

class _WordOfTheDayState extends State<WordOfTheDay> {
  SharedPreferences? _prefs;
  DateTime? _lastDate;
  String info = "";

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    String lastDateString = _prefs!.getString('lastDate') ?? '';
    info = _prefs!.getString('info') ?? "ನಮಸ್ಕಾರ - namaskāra - hello";
    setState(() {});
    if (lastDateString.isNotEmpty) {
      _lastDate = DateFormat('yyyy-MM-dd').parse(lastDateString);
    } else {
      _lastDate = DateTime.now().subtract(Duration(days: 1));
    }
    _setDateState();
  }

  Future<void> _setDateState() async {
    var time = _prefs!.getString('notificationTime') ?? "07:00:00";
    var splittedList = time.split(':');
    double hour = double.parse(splittedList[0]);
    double minute = double.parse(splittedList[1]);
    double notificationTime = hour + (minute / 60);
    DateTime now = DateTime.now();
    double nowTime = now.hour + (now.minute / 60);
    
    if ((_lastDate!.day != now.day) && (nowTime >= notificationTime)) {
      String jsonData = await randomWord();
      final Map<String, dynamic> mapData = jsonDecode(jsonData);
      List wordsData = [];

      for (var entry in mapData.values) {
        wordsData.add(entry);
      }

      final word = (wordsData..shuffle()).first;
      String english = word["english"];
      String kannada = word["kannada"];
      String transliteration = word["transliteration"];
      final newWord = "$kannada - $transliteration - $english";
      _prefs!.setString('info', newWord);
      setState(() {
        // set your state here
      });
      info = _prefs!.getString('info') ?? "";
      setState(() {});
      _prefs!.setString('lastDate', DateFormat('yyyy-MM-dd').format(now));
      _lastDate = now;
    }
  }

  Future<String> randomWord() async {
    final word = (vocabCards.toList()..shuffle()).first;
    final jsonData =
        await rootBundle.loadString("res/vocab/${word.topic}.json");
    return jsonData;
  }

  @override
  Widget build(BuildContext context) {
    // _setDateState();
    return SizedBox(
      height: ScreenSize.height! * 0.13,
      width: ScreenSize.width! * 0.95,
      child: Card(
        elevation: 5.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0)),
        ),
        color: const Color.fromARGB(255, 39, 101, 151),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text(
                'Word of the day',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: ScreenSize.width! * 0.82,
                child: Center(
                  child: Text(
                    info,
                    style: TextStyle(
                      fontSize: wordOfDaySize(info),
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
