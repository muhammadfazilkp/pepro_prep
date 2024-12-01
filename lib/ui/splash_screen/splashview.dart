
import 'package:education_media/ui/splash_screen/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Splashview extends StatelessWidget {
  const Splashview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewmodel>.reactive(
      viewModelBuilder: ()=>SplashViewmodel(),
       builder: (context,viewmodal,child){
        return const Scaffold(
backgroundColor: Colors.white,

body: Center(
  child: Text('Splash screen'),
),
        );
       });
  }
}
