import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:material_ui/material_ui.dart';

/// What happened when the app tried to speak.
enum SpeechResult { spoken, noKannadaVoice, failed }

/// Reads Kannada aloud with the device's text-to-speech engine.
///
/// Phones differ a lot here, so this:
/// - switches to Google's engine on Android when the default one (Samsung's,
///   for example) has no Kannada voice,
/// - plays through the iPhone silent switch, like any audio app,
/// - stops the current word when another is tapped instead of queueing,
/// - re-checks after a failure, so installing a voice fixes it without a
///   restart, and
/// - tells the caller when there's no Kannada voice, so the app can explain
///   how to get one (see [speakWithHelp]).
class Speech {
  Speech._();

  static const _language = 'kn-IN';
  static const _googleEngine = 'com.google.android.tts';
  static const _channel = MethodChannel('kannada_disco/tts');

  static final FlutterTts _tts = FlutterTts();
  static Future<bool>? _ready;

  /// The text being spoken right now, or null. Word cards listen to this to
  /// show which one is playing.
  static final ValueNotifier<String?> speaking = ValueNotifier(null);

  static bool get _supported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static Future<bool> _prepare() async {
    if (!_supported) return false;
    try {
      _tts.setCompletionHandler(() => speaking.value = null);
      _tts.setCancelHandler(() => speaking.value = null);
      _tts.setErrorHandler((_) {
        speaking.value = null;
        _ready = null; // Check the engine again next time.
      });

      if (Platform.isIOS) {
        // Without this, iOS mutes speech while the silent switch is on.
        await _tts.setSharedInstance(true);
        await _tts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.playback,
          [IosTextToSpeechAudioCategoryOptions.duckOthers],
          IosTextToSpeechAudioMode.spokenAudio,
        );
      }
      await _tts.awaitSpeakCompletion(false);

      if (!await _hasKannada() && Platform.isAndroid) {
        // Reconnect to Google's engine, which has Kannada. This also repairs
        // a connection made while no voice engine was installed or enabled
        // (the engine list is empty then, so don't rely on it). If Google's
        // engine is missing, Android connects to the default one instead.
        try {
          await _tts.setEngine(_googleEngine);
        } catch (e) {
          debugPrint('Could not switch text-to-speech engine: $e');
        }
      }
      if (!await _hasKannada()) return false;

      await _tts.setLanguage(_language);
      // A little slower than normal, which suits learners.
      await _tts.setSpeechRate(0.42);
      await _tts.setPitch(1);
      await _tts.setVolume(1);
      return true;
    } catch (e) {
      debugPrint('Text-to-speech setup failed: $e');
      return false;
    }
  }

  static Future<bool> _hasKannada() async =>
      await _tts.isLanguageAvailable(_language) == true;

  /// Speaks [text]. Safe to call repeatedly; a new call cuts off the last.
  static Future<SpeechResult> speak(String text) async {
    final ready = await (_ready ??= _prepare());
    if (!ready) {
      _ready = null; // The user may install a voice; try again next time.
      return SpeechResult.noKannadaVoice;
    }
    try {
      await _tts.stop();
      speaking.value = text;
      final result = await _tts.speak(spokenForm(text));
      if (result == 1) return SpeechResult.spoken;
      speaking.value = null;
      return SpeechResult.failed;
    } catch (e) {
      debugPrint('Text-to-speech failed: $e');
      speaking.value = null;
      _ready = null;
      return SpeechResult.failed;
    }
  }

  /// Speaks [text] and, if the phone can't, says why and how to fix it.
  static Future<void> speakWithHelp(BuildContext context, String text) async {
    final result = await speak(text);
    if (result == SpeechResult.spoken || !context.mounted) return;

    final noVoice = result == SpeechResult.noKannadaVoice;
    final canFix = !kIsWeb && Platform.isAndroid;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: const Duration(seconds: 6),
        content: Text(noVoice
            ? (canFix
                ? "Your phone needs a Kannada voice to read words aloud."
                : "This device doesn't have a Kannada voice yet. Look in "
                    "Settings > Accessibility > Spoken Content > Voices.")
            : "Couldn't play that. Check your volume and try again."),
        action: noVoice && canFix
            ? const SnackBarAction(
                label: "Get voice", onPressed: openVoiceSettings)
            : null,
      ));
  }

  /// Opens the screen for downloading text-to-speech voices (Android).
  static Future<void> openVoiceSettings() async {
    try {
      await _channel.invokeMethod('openVoiceSettings');
    } catch (e) {
      debugPrint('Could not open voice settings: $e');
    }
  }

  /// [text] as it should be read aloud: blanks ("___") read as "dash",
  /// alternatives ("ಅಮ್ಮ/ತಾಯಿ") with a pause instead of "slash", and the
  /// hyphens and brackets used in suffix tables dropped.
  static String spokenForm(String text) => text
      .replaceAll('___', 'ಡ್ಯಾಶ್')
      .replaceAll('/', ', ')
      .replaceAll(RegExp(r'[()\[\]]'), ' ')
      .replaceAll(RegExp(r'(^|\s)-|-(\s|$)'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
