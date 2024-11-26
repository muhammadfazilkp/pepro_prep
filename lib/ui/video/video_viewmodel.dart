import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewmodel extends ChangeNotifier {
  late VideoPlayerController controller;
  bool isVideoLoading = false;
  bool isError = false;
  static const int timeOutDuration = 30;
  Future<VideoPlayerController> init() async {
    await checkVideoPlatform();
    return controller;
  }

  Future<void> checkVideoPlatform() async {
    try {
      controller = VideoPlayerController.networkUrl(
        Uri(path: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4')
      );

      isVideoLoading = true;
      notifyListeners();

      await controller.initialize();

      controller.setLooping(true);
      isVideoLoading = false;
      notifyListeners();
    } catch (e) {
      isError = true;
      isVideoLoading = false;
      notifyListeners();
    }
  }

  void disposeController() {
    controller.dispose();
    super.dispose();
  }
}
