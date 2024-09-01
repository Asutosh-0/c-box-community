import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsPlayerItem extends StatefulWidget {
  final String videoUrl;
  const ReelsPlayerItem({super.key, required this.videoUrl});

  @override
  State<ReelsPlayerItem> createState() => _ReelsPlayerItemState();
}

class _ReelsPlayerItemState extends State<ReelsPlayerItem> {

  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl!)..initialize().then((value){
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width:size.width ,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.black87
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            videoPlayerController.value.isPlaying
                ? videoPlayerController.pause()
                : videoPlayerController.play();
          });
        },
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,

          child: VideoPlayer(
            videoPlayerController,
          ),
        ),
      ),
    );
  }
}
