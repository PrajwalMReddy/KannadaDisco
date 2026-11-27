import 'package:material_ui/material_ui.dart';

/// Shows a spinner while [future] loads, an error message if it fails, and
/// [builder]'s widget once the data is ready.
class AsyncContent<T> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;

  const AsyncContent({super.key, required this.future, required this.builder});

  @override
  State<AsyncContent<T>> createState() => _AsyncContentState<T>();
}

class _AsyncContentState<T> extends State<AsyncContent<T>> {
  // Held in state so a rebuild doesn't start loading again.
  late final Future<T> _future = widget.future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return widget.builder(context, snapshot.data as T);
      },
    );
  }
}

/// Placeholder for a topic that has no entries yet.
class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.hourglass_empty_rounded,
              size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text('Coming soon', style: theme.textTheme.titleLarge),
        ],
      ),
    );
  }
}
