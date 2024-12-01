import 'package:education_media/app/utils.dart';
import 'package:education_media/ui/login/login_response_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginViewModel extends ChangeNotifier {
  // TextEditingControllers for email and password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isLoggedIn = false;
  String? _errorMessage;
  LoginResponse? _loginResponse;

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

      if (response.statusCode == 200) {
        final responsedata = jsonDecode(response.body);
        _loginResponse = LoginResponse.fromJson(responsedata);
        _isLoggedIn = true;

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
}
