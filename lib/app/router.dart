import 'package:education_media/ui/catogory/catogory_view.dart';
import 'package:education_media/ui/chapters/chapter_view.dart';
import 'package:education_media/ui/home/home_view.dart';
import 'package:education_media/ui/lessons/lessons_list_view.dart';
import 'package:education_media/ui/login/login_view.dart';
import 'package:education_media/ui/signup/sign_up_screen.dart';
import 'package:education_media/ui/splash_screen/splashview.dart';
import 'package:education_media/ui/video/video_view.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class PageRouter {
  static Route<Object> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return MaterialPageRoute(
          builder: (_) => const Splashview(),
          settings: settings,
        );
      case RoutePaths.homeView:
        return MaterialPageRoute(
          builder: (_) => HomeView(),
          settings: settings,
        );

      case RoutePaths.signUp:
        return MaterialPageRoute(
            builder: (_) => const SignUpScreen(), settings: settings);

      case RoutePaths.videoView:
        return MaterialPageRoute(
          builder: (context) => const VideoView(),
          settings: settings,
        );
      case RoutePaths.login:
        return MaterialPageRoute(
            builder: (_) => const SignInScreen(), settings: settings);
      case RoutePaths.catogory:
        return MaterialPageRoute(builder: (_)=>const CategoryView(),settings: settings); 
      
      case RoutePaths.lessons:
          return MaterialPageRoute(builder: (_)=> LessonGridView(),settings: settings);        
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for page ${settings.name}'),
            ),
          ),
        );
    }
  }
}
