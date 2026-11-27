import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/element/async_content.dart';
import 'package:kannada_disco/resource/reference_entry.dart';
import 'package:kannada_disco/util/speech.dart';
import 'package:kannada_disco/util/util.dart';

/// A list of words or phrases loaded from `res/<type>/<topic>.json`.
///
/// Route arguments: `topic` (required), `heading` (optional title) and
/// `kids` (optional; hides entries without a kids picture).
class Reference extends StatelessWidget {
  final String type;

  const Reference({super.key, required this.type});

  Future<List<Map<String, dynamic>>> _loadEntries(String topic) async {
    final json = await rootBundle.loadString("res/$type/$topic.json");
    return (jsonDecode(json) as Map<String, dynamic>)
        .values
        .cast<Map<String, dynamic>>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String topic = args["topic"];
    final String? heading = args["heading"];
    final bool kids = args["kids"] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(heading ?? prettifyText(topic)),
        centerTitle: true,
        backgroundColor: kannadaBlue,
      ),
      body: AsyncContent<List<Map<String, dynamic>>>(
        future: _loadEntries(topic),
        builder: (context, entries) {
          if (kids) {
            entries = entries.where((e) => e["link"] != "").toList();
          }
          if (entries.isEmpty) return const ComingSoon();

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return GestureDetector(
                onTap: () => Speech.speak(entry["kannada"] ?? ""),
                child: ReferenceEntry(
                  english: entry["english"] ?? "",
                  kannada: entry["kannada"] ?? "",
                  transliteration: entry["transliteration"] ?? "",
                  imagePath: entry["link"],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
