import 'package:flutter_tts/flutter_tts.dart';

/// Reads Kannada text aloud with the device's text-to-speech engine.
class Speech {
  Speech._();

  static final FlutterTts _tts = FlutterTts();
  static bool _configured = false;

  static Future<void> speak(String text) async {
    if (!_configured) {
      await _tts.setLanguage("kn-IN");
      await _tts.setPitch(1);
      _configured = true;
    }
    // "___" marks a blank in phrases; read it as "dash".
    await _tts.speak(text.replaceAll("___", "ಡ್ಯಾಶ್"));
  }
}
