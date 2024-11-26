// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewmodel extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  // late  ChewieController chewieController;

  bool isVideoLoading = false;
  bool isError = false;
  static const int timeOutDuration = 30;

  Future<VideoPlayerController> init() async {
    await checkVideoPlatform();
    return videoPlayerController;
  }

  Future<void> checkVideoPlatform() async {
    try {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri(path: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      );
      isVideoLoading = true;
      notifyListeners();
      _initializeVideoPlayerFuture = videoPlayerController.initialize();
      videoPlayerController.setLooping(true);

      //  chewieController = ChewieController(
      //   // aspectRatio:  CircularProgressIndicator.strokeAlignOutside,
      //   // aspectRatio: ,
      //   videoPlayerController: videoPlayerController,
      //   autoPlay: true,
      //   looping: true,
      //   fullScreenByDefault: true
      // );

      isVideoLoading = false;
      notifyListeners();
    } catch (e) {
      isError = true;
      isVideoLoading = false;
      notifyListeners();
    }
  }

  void disposeController() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
