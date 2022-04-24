import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_media/basic_overlay_widget.dart';
import 'package:video_player/video_player.dart';

class DemoVideoPlayer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoVideoPlayerState();
  }
}

class DemoVideoPlayerState extends State<DemoVideoPlayer> {
  late VideoPlayerController _controller;
  String asset = "assets/trailer.mp4";

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(asset)
      ..setLooping(true)
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((_) => _controller.play());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            BasicOverlayWidget(controller: _controller)
          ],
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildMuteButton(),
          const SizedBox(
            width: 60,
          ),
          buildFilePlayButton(),
          const SizedBox(
            width: 60,
          ),
          buildNetworkPlayButton(),
        ],
      ),
    ]);
  }

  Widget buildMuteButton() {
    final isMuted = _controller.value.volume == 0;
    return CircleAvatar(
        backgroundColor: Colors.red,
        radius: 25,
        child: IconButton(
            onPressed: () => {_controller.setVolume(isMuted ? 1 : 0)},
            color: Colors.black,
            icon: Icon(isMuted ? Icons.volume_mute : Icons.volume_up)));
  }

  Widget buildFilePlayButton() => Container(
          child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.cyan,
        child: IconButton(
          onPressed: () async {
            final file = await pickVideoFile();
            if (file == null) return;
            _controller = VideoPlayerController.file(file)
              ..addListener(() => setState(() {}))
              ..setLooping(true)
              ..initialize().then((_) {
                _controller.play();
                setState(() {});
              });
          },
          icon: Icon(Icons.add),
        ),
      ));

  Future<File?> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) return null;
    print("file path: ${result.files.single.path}");
    return File(result.files.single.path ?? "");
  }

  Widget buildNetworkPlayButton() {
    return CircleAvatar(
        radius: 25,
        backgroundColor: Colors.green,
        child: IconButton(
            onPressed: () => {
                  _controller.dispose(),
                  _controller = VideoPlayerController.network(
                      "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4")
                    ..addListener(() => setState(() {}))
                    ..setLooping(true)
                    ..initialize().then((_) {
                      _controller.play();
                      setState(() {});
                    })
                },
            icon: Icon(Icons.network_cell),
            color: Colors.black));
  }
}
