import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kannada_disco/const/resource_topic.dart';
import 'package:kannada_disco/service/notification_service.dart';
import 'package:kannada_disco/util/prefs_keys.dart';
import 'package:kannada_disco/util/speech.dart';
import 'package:kannada_disco/util/util.dart';

/// Shows the word of the day. A new word appears once a day, after the
/// user's reminder time, so it matches the notification they received.
class WordOfTheDay extends StatefulWidget {
  const WordOfTheDay({super.key});

  @override
  State<WordOfTheDay> createState() => _WordOfTheDayState();
}

class _WordOfTheDayState extends State<WordOfTheDay> {
  static final _dateFormat = DateFormat('yyyy-MM-dd');

  String _todayWord = NotificationService.defaultWord;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _show(prefs.getString(PrefsKeys.todayWord) ??
        NotificationService.defaultWord);
    await _advanceIfDue(prefs);
  }

  void _show(String word) {
    if (!mounted) return;
    setState(() => _todayWord = word);
  }

  Future<void> _advanceIfDue(SharedPreferences prefs) async {
    final now = DateTime.now();
    final today = _dateFormat.format(now);
    if (prefs.getString(PrefsKeys.lastDate) == today) return;

    final parts = (await NotificationService.savedTime()).split(':');
    final reminder = DateTime(
        now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
    if (now.isBefore(reminder)) return;

    // Yesterday's "next" word (the one in the notification) becomes today's.
    final todayWord =
        prefs.getString(PrefsKeys.nextWord) ?? NotificationService.defaultWord;
    await prefs.setString(PrefsKeys.todayWord, todayWord);
    await prefs.setString(PrefsKeys.nextWord, await _randomWord());
    await prefs.setString(PrefsKeys.lastDate, today);
    _show(todayWord);

    // The reminder text is fixed when scheduled, so refresh it.
    await NotificationService.instance.scheduleDailyNotification();
  }

  Future<String> _randomWord() async {
    final topic = (vocabCards.toList()..shuffle()).first.topic;
    final json = await rootBundle.loadString("res/vocab/$topic.json");
    final words = (jsonDecode(json) as Map<String, dynamic>).values.toList()
      ..shuffle();
    final word = words.first;
    return "${word["kannada"]} - ${word["transliteration"]} - ${word["english"]}";
  }

  @override
  Widget build(BuildContext context) {
    final word = splitWordOfDay(_todayWord);
    final text = Theme.of(context).textTheme;
    const white = Colors.white;
    final muted = white.withValues(alpha: 0.8);

    return Material(
      color: white.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: white.withValues(alpha: 0.2)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Speech.speak(word.kannada),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 12, 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WORD OF THE DAY',
                      style: text.labelMedium!
                          .copyWith(color: muted, letterSpacing: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      word.kannada,
                      style: text.headlineMedium!
                          .copyWith(color: white, fontWeight: FontWeight.w700),
                    ),
                    if (word.transliteration.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(word.transliteration,
                          style: text.titleMedium!.copyWith(color: white)),
                    ],
                    if (word.english.isNotEmpty)
                      Text(word.english,
                          style: text.bodyLarge!.copyWith(color: muted)),
                  ],
                ),
              ),
              const Icon(Icons.volume_up_rounded, color: white, size: 32),
            ],
          ),
        ),
      ),
    );
  }
}
