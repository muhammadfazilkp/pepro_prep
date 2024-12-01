import 'package:education_media/service/apiservice.dart';
import 'package:education_media/ui/catogory/catogory_view_model.dart';
import 'package:education_media/ui/chapters/chapter_veiwmodel.dart';
import 'package:education_media/ui/lessons/lessons_viewmodel.dart';
import 'package:education_media/ui/login/login_view_model.dart';
import 'package:education_media/ui/splash_screen/splash_viewmodel.dart';
import 'package:education_media/ui/splash_screen/splash_viewmodel.dart';
import 'package:education_media/ui/video/video_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(
    create: (context) => VideoViewmodel(),
  ),
  ChangeNotifierProvider(
    create: (context) => LoginViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => Apiservice(),
  ),

  ChangeNotifierProvider(create: (context)=>ChapterVeiwmodel()),
    ChangeNotifierProvider(create: (context)=>LessonsViewmodel())

]; 

List<SingleChildWidget> dependentServices = [
  ChangeNotifierProvider(
    create: (context) => SplashViewmodel(),
  )
];
