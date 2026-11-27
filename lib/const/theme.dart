import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/color.dart';

/// The app's look, in light and dark. Screens should take colours and text
/// styles from `Theme.of(context)` rather than hard-coding them.
ThemeData buildTheme(Brightness brightness) {
  final scheme =
      ColorScheme.fromSeed(seedColor: kannadaSeed, brightness: brightness);
  final dark = brightness == Brightness.dark;

  // The navy bar is the app's signature; in dark mode it blends in instead.
  final barColor = dark ? scheme.surfaceContainer : kannadaBlue;
  final onBar = dark ? scheme.onSurface : Colors.white;

  return ThemeData(
    colorScheme: scheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: barColor,
      foregroundColor: onBar,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onBar,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 1,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
    timePickerTheme: TimePickerThemeData(
      helpTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: scheme.primary,
      ),
    ),
  );
}

/// Text styles shared by several screens.
extension KannadaText on BuildContext {
  /// Kannada script, shown in the primary colour throughout the app.
  TextStyle get kannadaStyle => Theme.of(this)
      .textTheme
      .titleLarge!
      .copyWith(color: Theme.of(this).colorScheme.primary);

  /// Section headings such as "Vocabulary".
  TextStyle get sectionStyle => Theme.of(this).textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
        color: Theme.of(this).colorScheme.primary,
      );
}
