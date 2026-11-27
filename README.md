# KannadaDisco

An app for learning spoken Kannada: a resource library (reading, vocabulary,
grammar, phrasebook), a structured course, a daily word of the day, and a Kids
section with pictures, rhymes and conversations.

Current version: 1.2.0 (build 3)

## Running it

```
flutter pub get
flutter run
```

## Project layout

- `lib/` – app code (`screen/` pages, `element/` shared widgets, `resource/`
  word lists, `course/` lessons, `service/` notifications)
- `course/` – course lessons as Markdown
- `res/` – word lists as JSON (`reading`, `vocab`, `gram`, `conv`)
- `assets/` – logo and Kids section pictures

## Releasing

- Bump `version:` in `pubspec.yaml` (the number after `+` must go up) and
  `appVersion` in `lib/element/side_bar.dart`.
- Release signing needs `android/key.properties` and the upload keystore it
  points to. Neither is in git.
