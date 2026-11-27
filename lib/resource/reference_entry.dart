import 'package:material_ui/material_ui.dart';

/// One word or phrase: an optional picture, the English, Kannada and
/// transliteration, and a speaker icon.
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
    final image = imagePath;
    final hasImage = image != null && image.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: [
            if (hasImage) ...[
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
              const SizedBox(width: 20),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(english, style: const TextStyle(fontSize: 20.0)),
                  const SizedBox(height: 15),
                  Text(
                    kannada,
                    style: const TextStyle(
                        height: 1, fontSize: 20.0, color: Colors.blue),
                  ),
                  const SizedBox(height: 15),
                  Text(transliteration,
                      style: const TextStyle(height: 1, fontSize: 20)),
                ],
              ),
            ),
            const Icon(Icons.volume_up, size: 30, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
