import 'package:education_media/app/utils.dart';
import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/service/apiservice.dart';
import 'package:education_media/service/navigation_service.dart';
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

    if(key==null&&secretKey==null){
      getsecretKey();
    }
    Uri url = buildBaseUrl('lms.lms.utils.get_courses');
    String credentials = 'token $key:$secretKey';

      final headers = {
        "Authorization": " $credentials",
        "x-secret-key": credentials,
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };
    try {
      final response = await http.get(url,headers: headers);
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
      debugPrint('Key: $key : SecretKey: $secretKey');

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Logout successful')));
      removUserprf();
       navigationService.pushNamedAndRemoveUntil(RoutePaths.login);
    } catch (e) {
      debugPrint('Error during logout: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Logout failed: $e')));
    }
  }

  void removUserprf() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('isLoggedin');
    key=null;
    secretKey=null;
    notifyListeners();
  }

 Future<void> getsecretKey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    key = pref.getString('loginKey');
    secretKey = pref.getString('loginSecretKey');
        debugPrint('Loaded keys: key=$key, secretKey=$secretKey');

    notifyListeners();
  }
}
