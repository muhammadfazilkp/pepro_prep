import 'package:education_media/app/utils.dart';
import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/service/apiservice.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'course_model.dart'; // Import the model file

class CatogoryViewModel extends ChangeNotifier {
  CatogoryViewModel({required Apiservice apiservice})
      : _apiservice = apiservice;

  List<Course> liveCourses = [];
  bool isLoading = true;
  final Apiservice _apiservice;
  String? key;
  String? secretKey;

  Future<void> fetchLiveCourses() async {
    Uri url = buildBaseUrl('lms.lms.utils.get_courses');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> liveData = data['message']['live'] ?? [];
        liveCourses = liveData.map((json) => Course.fromJson(json)).toList();
      } else {
        print('Failed to load courses. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching courses: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await _apiservice.logout(key.toString(), secretKey.toString());

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Logout successful')));
      removUserprf();
      Navigator.pushReplacementNamed(context, RoutePaths.login);
    } catch (e) {
      debugPrint('Error during logout: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Logout failed: $e')));
    }
  }

  void removUserprf() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('isLoggedin');
    notifyListeners();
  }

  getsecretKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    key = pref.getString('loginKey');
    secretKey = pref.getString('loginSecretKey');
    notifyListeners();
  }
}
