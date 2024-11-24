
import 'package:education_media/ui/video/video_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/model_future_builder.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoViewmodel>.reactive(
      onViewModelReady: (viewModel) => viewModel.init(),
      builder: (context, model, child) {
        return ModelFutureBuilder<VideoPlayerController>(
          busy: model.isVideoLoading,
          data: model.videoPlayerController,
          error: const Center(
            child: Text("Error loading video, showing fallback"),
          ),
          loading: const Center(child: CircularProgressIndicator()),
          builder: (context, data, _) {
            if (model.videoPlayerController == null ||
                model.videoPlayerController.value.isInitialized) {
              return const Center(child: CircularProgressIndicator());
            }
            final controller = model.videoPlayerController;

            return Scaffold(
              appBar: AppBar(
                leading: const Icon(
                  Icons.arrow_back,
                  size: 13,
                  color: Colors.black45,
                ),
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    // color: Colors.teal,
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {
                      controller.play();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () {
                      controller.pause();
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amberAccent,
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/poster.jpg'),
                                  fit: BoxFit.cover)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Head Line Subject ',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              Text(
                                '5:19 ',
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      viewModelBuilder: () => VideoViewmodel(),
    );
  }
}
