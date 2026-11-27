import 'package:material_ui/material_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Plays a YouTube video. Double-tap or go back to close.
class YoutubeScreen extends StatefulWidget {
  final String videoId;

  const YoutubeScreen({super.key, required this.videoId});

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late final YoutubePlayerController _controller =
      YoutubePlayerController.fromVideoId(
    videoId: widget.videoId,
    autoPlay: false,
  );

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => Navigator.pop(context),
      child: Scaffold(
        body: SafeArea(
          child: Center(child: YoutubePlayer(controller: _controller)),
        ),
      ),
    );
  }
}
