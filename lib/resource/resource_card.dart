import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/util/util.dart';

/// One topic tile in a [ResourceGrid].
class ResourceCard extends StatelessWidget {
  final String topic;
  final String resourceType;

  const ResourceCard(
      {super.key, required this.topic, required this.resourceType});

  static const _padding = 8.0;
  static const _maxLines = 3;

  static TextStyle _style(BuildContext context) => Theme.of(context)
      .textTheme
      .titleSmall!
      .copyWith(fontWeight: FontWeight.w600, height: 1.25);

  /// The tile height that fits [_maxLines] lines at the current text size.
  static double height(BuildContext context) {
    final style = _style(context);
    final line =
        MediaQuery.textScalerOf(context).scale(style.fontSize!) * style.height!;
    return line * _maxLines + _padding * 2 + 4;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, "/res/$resourceType",
            arguments: {"topic": topic}),
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: Center(
            child: Text(
              prettifyText(topic),
              textAlign: TextAlign.center,
              maxLines: _maxLines,
              overflow: TextOverflow.ellipsis,
              style: _style(context),
            ),
          ),
        ),
      ),
    );
  }
}
