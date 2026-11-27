String prettifyText(String topic) {
  String temp = topic.replaceAll("_", " ");
  final List<String> words = temp.split(' ');

  final capitalizedWords = words.map((word) {
    if (word.trim().isNotEmpty) {
      final String firstLetter = word.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = word.trim().substring(1);

      return '$firstLetter$remainingLetters';
    }

    return '';
  });

  return capitalizedWords.join(' ').replaceAll("And", "&");
}

/// Splits a saved word of the day, "ಕನ್ನಡ - kannaḍa - Kannada", into its
/// Kannada, transliteration and English parts. Anything else is returned as
/// the Kannada part with the others empty.
({String kannada, String transliteration, String english}) splitWordOfDay(
    String word) {
  final parts = word.split(' - ');
  if (parts.length != 3) {
    return (kannada: word, transliteration: '', english: '');
  }
  return (
    kannada: parts[0].trim(),
    transliteration: parts[1].trim(),
    english: parts[2].trim(),
  );
}
