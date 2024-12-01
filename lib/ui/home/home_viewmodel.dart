// ignore_for_file: non_constant_identifier_names

import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/models/coursemodel.dart';
import 'package:education_media/service/apiservice.dart';
import 'package:education_media/service/navigation_service.dart';
import 'package:education_media/ui/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  // ignore: avoid_types_as_parameter_names
  HomeViewmodel({required Apiservice, required LoginViewModel})
      : _apiservice = Apiservice,
        _loginViewModel = LoginViewModel;

  Coureses? coureses;
  // final LoginResponse loginResponse
  final Apiservice _apiservice;
  final LoginViewModel _loginViewModel;
  String? loginKey;
  String? loginSecretKey;
  void init() async {
    await getKeys();
    getUserDetails();
  }

  Future<Coureses?> getUserDetails() async {
    debugPrint('Login Key : $loginKey : SecretKey : $loginSecretKey');
    try {
      coureses = await _apiservice.fetchCourseData(
        apikey: loginKey.toString(),
        secretKey: loginSecretKey.toString(),
      );
      debugPrint("Course Data: ${coureses?.data!.title}");
    } catch (e) {
      debugPrint("Error fetching course data: $e");
    }
    return coureses;
  }

  Future<void> getKeys() async {
    SharedPreferences prf = await SharedPreferences.getInstance();
    loginKey = prf.getString('loginKey');
    loginSecretKey = prf.getString('loginSecretKey');
  }

  loGoutUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('isLoggedin');
    navigationService.pushNamedAndRemoveUntil(RoutePaths.login);
    notifyListeners();
  }
}
