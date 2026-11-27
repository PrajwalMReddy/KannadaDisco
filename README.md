# KannadaDisco

An app for learning spoken Kannada: a resource library (reading, vocabulary,
grammar, phrasebook), a structured course, a daily word of the day, and a Kids
section with pictures, rhymes and conversations.

Current version: 1.2.0 (build 10)

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

See [RELEASING.md](RELEASING.md) for Google Play and the App Store, including
the one-time setup for each. Store text and screenshots are in
[docs/](docs/store-listing.md); the privacy policy is [PRIVACY.md](PRIVACY.md).
