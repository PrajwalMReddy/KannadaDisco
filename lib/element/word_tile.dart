import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/util/speech.dart';

/// One word or phrase: what it means, the Kannada, how to say it, and a play
/// button. Tapping anywhere plays it, and the tile shows while it's playing.
///
/// With [card] it draws its own card (word lists); without, it's a row for
/// grouping inside another card (lessons).
class WordTile extends StatelessWidget {
  final String english;
  final String kannada;
  final String transliteration;

  /// Asset path of a picture, or null/empty for none.
  final String? imagePath;
  final bool card;

  const WordTile({
    super.key,
    required this.english,
    required this.kannada,
    required this.transliteration,
    this.imagePath,
    this.card = true,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: Speech.speaking,
      builder: (context, speaking, _) {
        final playing = speaking != null && speaking == kannada;
        final content = _content(context, playing);
        final scheme = Theme.of(context).colorScheme;

        if (!card) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: playing
                ? scheme.primaryContainer.withValues(alpha: 0.5)
                : Colors.transparent,
            child: content,
          );
        }
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: playing
                ? BorderSide(color: scheme.primary, width: 2)
                : BorderSide.none,
          ),
          child: content,
        );
      },
    );
  }

  Widget _content(BuildContext context, bool playing) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final image = imagePath;
    final hasImage = image != null && image.isNotEmpty;

    return InkWell(
      onTap: () => Speech.speakWithHelp(context, kannada),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        child: Row(
          children: [
            if (hasImage) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  // Pictures are drawn on white, so keep them on white in
                  // dark mode too.
                  color: Colors.white,
                  width: 72,
                  height: 72,
                  padding: const EdgeInsets.all(4),
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
                  // Dictionary order: the word, how to say it, what it means.
                  Text(
                    kannada,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                  Text(
                    transliteration,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: scheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(english,
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            PlayButton(
              playing: playing,
              label: english,
              onPressed: () => Speech.speakWithHelp(context, kannada),
            ),
          ],
        ),
      ),
    );
  }
}

/// A round play button that shows sound waves while playing.
class PlayButton extends StatelessWidget {
  final bool playing;

  /// What is played, for screen readers.
  final String label;
  final VoidCallback onPressed;

  const PlayButton({
    super.key,
    required this.playing,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final icon =
        Icon(playing ? Icons.graphic_eq_rounded : Icons.volume_up_rounded);
    final tooltip = 'Listen to "$label"';
    return playing
        ? IconButton.filled(onPressed: onPressed, tooltip: tooltip, icon: icon)
        : IconButton.filledTonal(
            onPressed: onPressed, tooltip: tooltip, icon: icon);
  }
}
