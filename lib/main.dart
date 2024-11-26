import 'package:education_media/app/provider.dart';
import 'package:education_media/app/router.dart';
import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/widgets/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'service/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          builder: (context, child) {
            ScreenSize.init(context);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.1),
              child: child ?? const SizedBox(),
            );
          },
          debugShowCheckedModeBanner: false,
          initialRoute: RoutePaths.login,
          onGenerateRoute: PageRouter.generateRoute,
          navigatorKey: NavigationService.navigationKey,
        ),
      ),
    );
  }
}
