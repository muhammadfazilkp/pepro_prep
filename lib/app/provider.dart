import 'package:education_media/ui/login/login_view_model.dart';
import 'package:education_media/ui/video/video_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (context) => VideoViewmodel(),),
 ChangeNotifierProvider(create: (context)=>LoginViewModel(),)
];

List<SingleChildWidget> dependentServices = [];
