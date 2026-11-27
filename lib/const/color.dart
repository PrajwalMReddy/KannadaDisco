import 'package:material_ui/material_ui.dart';

/// The navy of the app bar and home header.
const kannadaBlue = Color.fromARGB(255, 11, 31, 48);

/// The blue the colour scheme is generated from.
const kannadaSeed = Color.fromARGB(255, 39, 101, 151);

/// The home screen header, from navy to the brand blue.
const headerGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [kannadaBlue, Color.fromARGB(255, 29, 66, 97), kannadaSeed],
);
