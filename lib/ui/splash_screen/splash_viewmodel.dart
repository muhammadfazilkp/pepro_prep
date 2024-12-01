import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/service/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewmodel extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool("isLoggedin") ?? false;

    if (_isLoggedIn) {
      debugPrint('work Flow started');
      navigationService.pushNamed(RoutePaths.homeView);
    } else {
      navigationService.pushNamed(RoutePaths.loginView);
       debugPrint('ON Going login screen ');
    }

    notifyListeners();
  }
}
