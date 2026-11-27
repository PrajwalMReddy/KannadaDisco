import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/theme.dart';

/// One word or phrase: an optional picture, the English, Kannada and
/// transliteration, and a speaker icon.
class ReferenceEntry extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  /// Asset path of a picture, or null/empty for none.
  final String? imagePath;
  final VoidCallback? onTap;

  const ReferenceEntry({
    super.key,
    required this.english,
    required this.kannada,
    required this.transliteration,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = imagePath;
    final hasImage = image != null && image.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
            child: Row(
              children: [
                if (hasImage) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      // Pictures are drawn on white, so keep them on white
                      // in dark mode too.
                      color: Colors.white,
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(english, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(kannada, style: context.kannadaStyle),
                      const SizedBox(height: 2),
                      Text(
                        transliteration,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onTap,
                  tooltip: 'Listen',
                  icon: Icon(Icons.volume_up_rounded,
                      size: 28, color: theme.colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
