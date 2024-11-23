import 'package:education_media/ui/video/video_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );}
}


// import 'package:education_media/ui/video/video_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:video_player/video_player.dart';

// import '../../widgets/model_future_builder.dart';

// class VideoView extends StatelessWidget {
//   const VideoView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<VideoViewmodel>.reactive
//     (
//       builder: (context, model, child) {
        
    
//       return FutureBuilder<void>(
       
//         future: model.init() ,
//         builder: (context, snapshot) {
          
//           return ModelFutureBuilder<void>(
            
//             busy:model.isVideoLoading,
//             data: model.controller,
//             error: const Center(
//               child: Text("Error loading video, showing fallback"),
//             ),
//             loading: const Center(child: CircularProgressIndicator()),
//             builder: (context, data, child) {
//               final controller = VideoViewmodel().controller;
      
//               return Scaffold(
//                 appBar: AppBar(
//                   leading: const Icon(Icons.arrow_back),
//                 ),
//                 body: Column(
//                   children: [
//                     AspectRatio(
//                       aspectRatio: controller.value.aspectRatio,
//                       child: VideoPlayer(controller),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.play_arrow),
//                       onPressed: () {
//                         controller.play();
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.pause),
//                       onPressed: () {
//                         controller.pause();
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       );
      
//       },
//        viewModelBuilder: () => VideoViewmodel(),
//     );
//   }
// }
