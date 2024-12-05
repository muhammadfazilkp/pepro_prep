import 'package:education_media/app/utils.dart';
import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/service/navigation_service.dart';
import 'package:education_media/ui/login/login_response_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../chapters/chapter_veiwmodel.dart';

class LoginViewModel extends ChangeNotifier {
  // TextEditingControllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _errorMessage;
  LoginResponse? _loginResponse;
  String? logdedUser;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get errorMessage => _errorMessage;
  LoginResponse? get loginResponse => _loginResponse;

  // Dispose controllers when the ViewModel is destroyed
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void init(){
    if(_isLoggedIn){
      navigationService.pushNamedAndRemoveUntil(RoutePaths.catogory);
    }
    debugPrint('userNot fount');
  }

  // Login function
  Future<void> login() async {
    Uri url = buildBaseUrl('rest_auth.rest_auth.api.auth.login');
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        url,
        body: {
          'username': emailController.text.trim(),
          'password': passwordController.text.trim(),

        },
      );

   debugPrint('email:${emailController.text} passcode: ${passwordController.text}');
   
      if (response.statusCode == 200) {
        final responsedata = jsonDecode(response.body);
        debugPrint('Full Response Login: $responsedata');
        logdedUser=responsedata['LoggedIn'];
        debugPrint('userLogedIn: $logdedUser');
        _loginResponse = LoginResponse.fromJson(responsedata);
        _isLoggedIn = true;
        notifyListeners();
        navigationService.pushNamed(RoutePaths.catogory);
        getUserKeys(
            loginKey: _loginResponse!.keyDetails.apiKey,
            loginSecretKey: _loginResponse!.keyDetails.apiSecret);
        debugPrint('loginKey : ${_loginResponse!.keyDetails.apiKey}');
        debugPrint('SecretKey : ${_loginResponse!.keyDetails.apiSecret}');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedin", true);
      } else {
        final error = jsonDecode(response.body);
        _errorMessage = error['message'] ?? 'An error occurred';
      }
    } catch (e) {
      _errorMessage = 'Could not connect to the server';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void getUserKeys(
      {required String loginKey, required String loginSecretKey}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("loginKey", loginKey);
    pref.setString("loginSecretKey", loginSecretKey);
    notifyListeners();
  }
}
