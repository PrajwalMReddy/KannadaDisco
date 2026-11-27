import 'package:material_ui/material_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/screen/rhymes_list.dart';
import 'package:kannada_disco/screen/youtube_screen.dart';

/// One rhyme: description, a video thumbnail that opens the video, and the
/// lyrics in Kannada and transliteration.
class RhymeDetailScreen extends StatelessWidget {
  final Rhyme rhyme;

  const RhymeDetailScreen({super.key, required this.rhyme});

  static const _boldText = TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(rhyme.name),
        centerTitle: true,
        backgroundColor: kannadaBlue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text(rhyme.description, textAlign: TextAlign.center, style: _boldText),
          const SizedBox(height: 16),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => YoutubeScreen(videoId: rhyme.videoId)),
            ),
            child: SizedBox(
              height: 300,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    YoutubePlayerController.getThumbnail(
                        videoId: rhyme.videoId),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const ColoredBox(color: Colors.black12),
                  ),
                  const Center(
                    child: Icon(Icons.play_circle_fill,
                        size: 64, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            rhyme.kannada,
            textAlign: TextAlign.center,
            style: _boldText.copyWith(color: Colors.blue),
          ),
          const SizedBox(height: 28),
          Text(rhyme.transliteration,
              textAlign: TextAlign.center, style: _boldText),
        ],
      ),
    );
  }
}
