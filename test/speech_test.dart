import 'package:flutter_test/flutter_test.dart';

import 'package:kannada_disco/util/speech.dart';

void main() {
  test('blanks are read as "dash"', () {
    expect(Speech.spokenForm('ನನ್ನ ಹೆಸರು ___'), 'ನನ್ನ ಹೆಸರು ಡ್ಯಾಶ್');
  });

  test('alternatives get a pause instead of "slash"', () {
    expect(Speech.spokenForm('ಅಮ್ಮ/ತಾಯಿ'), 'ಅಮ್ಮ, ತಾಯಿ');
  });

  test('suffix hyphens and brackets are not read out', () {
    expect(Speech.spokenForm('-ಬೇಡಿ'), 'ಬೇಡಿ');
    expect(Speech.spokenForm('ಮಾಡು -'), 'ಮಾಡು');
    expect(Speech.spokenForm('[ಕ]'), 'ಕ');
  });

  test('hyphens inside a word are kept', () {
    expect(Speech.spokenForm('ಸಹ-ಪ್ರಯಾಣಿಕ'), 'ಸಹ-ಪ್ರಯಾಣಿಕ');
  });
}
