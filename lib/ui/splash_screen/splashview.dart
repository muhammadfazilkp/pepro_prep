import 'package:education_media/app/images.dart';
import 'package:education_media/ui/splash_screen/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Splashview extends StatelessWidget {
  const Splashview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewmodel>.reactive(
      onViewModelReady: (model) => model.checkLoginStatus(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      splashImage,
                    ),
                    fit: BoxFit.cover)),
          ),
        );
      },
      viewModelBuilder: () => SplashViewmodel(),
    );
  }
}
