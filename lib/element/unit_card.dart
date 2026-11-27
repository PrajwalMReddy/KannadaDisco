import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/theme.dart';

/// A row card used for course lessons, Kids section topics and rhymes:
/// an optional badge, a title, a subtitle and a chevron.
class UnitCard extends StatelessWidget {
  final String title;
  final String subtitle;

  /// Shows [subtitle] in the Kannada style rather than as plain English.
  final bool kannadaSubtitle;
  final Widget? leading;
  final VoidCallback? onTap;

  const UnitCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.kannadaSubtitle = true,
    this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitleStyle = kannadaSubtitle
        ? context.kannadaStyle.copyWith(fontSize: 18)
        : theme.textTheme.bodyMedium!
            .copyWith(color: theme.colorScheme.onSurfaceVariant);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
            child: Row(
              children: [
                if (leading != null) ...[leading!, const SizedBox(width: 16)],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: theme.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: subtitleStyle),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right,
                    color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A round badge with a lesson number.
class NumberBadge extends StatelessWidget {
  final int number;

  const NumberBadge(this.number, {super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: 20,
      backgroundColor: scheme.primaryContainer,
      foregroundColor: scheme.onPrimaryContainer,
      child: Text('$number',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
    );
  }
}

/// A round badge with an emoji, for the Kids section.
class EmojiBadge extends StatelessWidget {
  final String emoji;

  const EmojiBadge(this.emoji, {super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      child: Text(emoji, style: const TextStyle(fontSize: 26)),
    );
  }
}
