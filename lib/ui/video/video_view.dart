// import 'package:chewie/chewie.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final String videoUrl;

  const VideoView({Key? key, required this.videoUrl}) : super(key: key);

  @override
  VideoViewState createState() => VideoViewState();
}

class VideoViewState extends State<VideoView> with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _controller,
            autoPlay: true,
            looping: true,
            showControls: true,
            allowMuting: true,
            allowFullScreen: true,
          );
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          // child: VideoPlayer(_controller),
          child: Chewie(controller: _chewieController,),
        ),
        // Row(
        //   children: [
        //     IconButton(
        //       icon: Icon(
        //         _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //       ),
        //       onPressed: () {
        //         setState(() {
        //           if (_controller.value.isPlaying) {
        //             _controller.pause();
        //           } else {
        //             _controller.play();
        //           }
        //         });
        //       },
        //     ),
        //     Text(_formatDuration(_controller.value.position)),
        //     Expanded(
        //       child: Slider(
        //         value: _controller.value.position.inSeconds.toDouble(),
        //         max: _controller.value.duration.inSeconds.toDouble(),
        //         onChanged: (value) {
        //           _controller.seekTo(Duration(seconds: value.toInt()));
        //         },
        //       ),
        //     ),
        //     Text(_formatDuration(_controller.value.duration)),
        //   ],
        // ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:"
        "${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
  }
}
