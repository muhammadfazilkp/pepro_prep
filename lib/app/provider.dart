import 'package:education_media/ui/video/video_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (context) => VideoViewmodel(),)
];

List<SingleChildWidget> dependentServices = [];
