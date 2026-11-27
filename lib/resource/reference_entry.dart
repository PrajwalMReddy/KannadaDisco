import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/element/word_tile.dart';

/// One entry in a word list: a [WordTile] card with list spacing.
class ReferenceEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  /// Asset path of a picture, or null/empty for none.
  final String? imagePath;

  const ReferenceEntry({
    super.key,
    required this.english,
    required this.kannada,
    required this.transliteration,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: WordTile(
        english: english,
        kannada: kannada,
        transliteration: transliteration,
        imagePath: imagePath,
      ),
    );
  }
}
