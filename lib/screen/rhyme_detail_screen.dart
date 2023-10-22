import 'package:flutter/material.dart';
import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/screen/youtube_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RhymeDetailScreen extends StatefulWidget {
  final String name;
  final String kannadaName;
  final String description;
  final String english;
  final String kannada;
  final String transliteration;
  final String link;
  const RhymeDetailScreen(
      {super.key,
      required this.name,
      required this.kannadaName,
      required this.description,
      required this.english,
      required this.kannada,
      required this.transliteration,
      required this.link});

  @override
  State<RhymeDetailScreen> createState() => _RhymeDetailScreenState();
}

class _RhymeDetailScreenState extends State<RhymeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: kannadaBlue,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YoutubeScreen(videoId: widget.link),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: 100,
                // height: 100,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // YoutubePlayer(
                    //   controller: _controller,
                    //   showVideoProgressIndicator: true,
                    //   progressIndicatorColor: Colors.red,
                    // ),
                    Expanded(
                        child: Image.network(
                      YoutubePlayer.getThumbnail(
                        videoId: widget.link,
                      ),
                      fit: BoxFit.fill,
                      errorBuilder: (context, url, error) => Icon(Icons.play_arrow, size: 50, color: Colors.grey,),
                    )),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.kannada,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.transliteration,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
