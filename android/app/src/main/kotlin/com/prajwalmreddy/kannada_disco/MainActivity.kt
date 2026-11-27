package com.prajwalmreddy.kannada_disco

import android.content.ActivityNotFoundException
import android.content.Intent
import android.provider.Settings
import android.speech.tts.TextToSpeech
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Lets the app send people to download a Kannada text-to-speech voice.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "kannada_disco/tts")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "openVoiceSettings" -> result.success(openVoiceSettings())
                    else -> result.notImplemented()
                }
            }
    }

    /** Tries the most specific screen first: Google's voice downloads. */
    private fun openVoiceSettings(): Boolean {
        val candidates = listOf(
            Intent(TextToSpeech.Engine.ACTION_INSTALL_TTS_DATA)
                .setPackage("com.google.android.tts"),
            Intent("com.android.settings.TTS_SETTINGS"),
            Intent(Settings.ACTION_SETTINGS),
        )
        for (intent in candidates) {
            try {
                startActivity(intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK))
                return true
            } catch (_: ActivityNotFoundException) {
                // Try the next one.
            }
        }
        return false
    }
}
