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

  return capitalizedWords.join(' ');
}
