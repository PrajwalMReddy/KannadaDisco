import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'package:kannada_disco/element/async_content.dart';
import 'package:kannada_disco/element/unit_card.dart';
import 'package:kannada_disco/screen/rhyme_detail_screen.dart';

/// The list of rhymes in the Kids section.
class RhymesList extends StatelessWidget {
  final String type;
  final String topic;

  const RhymesList({super.key, required this.type, required this.topic});

  Future<List<Rhyme>> _loadRhymes() async {
    final json = await rootBundle.loadString("res/$type/$topic.json");
    return (jsonDecode(json) as Map<String, dynamic>)
        .values
        .map((e) => Rhyme.fromJson(e as Map<String, dynamic>))
        // Rhymes without a video are not ready to show yet.
        .where((rhyme) => rhyme.videoId.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rhymes'),
      ),
      body: AsyncContent<List<Rhyme>>(
        future: _loadRhymes(),
        builder: (context, rhymes) {
          if (rhymes.isEmpty) return const ComingSoon();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rhymes.length,
            itemBuilder: (context, index) {
              final rhyme = rhymes[index];
              return UnitCard(
                title: rhyme.name,
                subtitle: rhyme.kannadaName,
                leading: const EmojiBadge('🎵'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => RhymeDetailScreen(rhyme: rhyme)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Rhyme {
  final String name;
  final String kannadaName;
  final String description;
  final String kannada;
  final String transliteration;

  /// YouTube video ID.
  final String videoId;

  const Rhyme({
    required this.name,
    required this.kannadaName,
    required this.description,
    required this.kannada,
    required this.transliteration,
    required this.videoId,
  });

  factory Rhyme.fromJson(Map<String, dynamic> json) => Rhyme(
        name: json["name"] ?? "",
        kannadaName: json["kannadaName"] ?? "",
        description: json["description"] ?? "",
        kannada: json["kannada"] ?? "",
        transliteration: json["transliteration"] ?? "",
        videoId: json["link"] ?? "",
      );
}
