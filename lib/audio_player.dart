import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoAudioPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoAudioPlayerState();
  }
}

class DemoAudioPlayerState extends State<DemoAudioPlayer> {
  final audioPlayer = AudioPlayer();
  var duration = Duration.zero;
  var position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {});
    });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = audioPlayer.state == PlayerState.PLAYING;

    return Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              position = Duration(seconds: value.toInt());
              audioPlayer.seek(position);
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_printDuration(position)),
              Text(_printDuration(duration))
            ],
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.green,
          child: IconButton(
              color: Colors.white,
              onPressed: () async {
                if (isPlaying) {
                  audioPlayer.pause();
                } else {
                  final player = AudioCache(prefix: 'assets/');
                  final url = await player.load('exampleSong.mp3');
                  audioPlayer.play(url.path, isLocal: true);
                }
              },
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow)),
        )
      ],
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
