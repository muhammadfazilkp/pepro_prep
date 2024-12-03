import 'dart:convert';
import 'package:education_media/ui/catogory/catogory_view_model.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:http/http.dart' as http;
import 'package:education_media/ui/chapters/chapter_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterVeiwmodel extends ChangeNotifier {
  ChapterVeiwmodel();

  List<Chapter> chapters = [];
  bool isLoadingchapters = true;

  String? loginKey;
  String? loginSecretKey;

  void init() async {
    _disableScreenshot();
    getKeys();
  }

  getKeys() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loginKey = pref.getString('loginKey');
    loginSecretKey = pref.getString('loginSecretKey');
    notifyListeners();
  }

  Future<void> fetchChapters(String courseName) async {
    //  String encodedPath = "https://peproprep.edusuite.store/api/resource/Course Chapter"
    //     .replaceAll(" ","%20");

    final Uri url = Uri.parse(
        "https://peproprep.edusuite.store/api/resource/Course%20Chapter");
    try {
      String credentials = "token 6e874616bdffac3:59a589ce127cc2a";

      final headers = {
        "Authorization": " $credentials",
        "x-secret-key": credentials,
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> chaptersData = data['data'] ?? [];
        chapters = chaptersData.map((json) => Chapter.fromJson(json)).toList();
      } else {
        debugPrint(
            'Failed to load chapters. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching chapters: $e');
    }
    isLoadingchapters = false;
    notifyListeners();
  }

  Future<void> _disableScreenshot() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
   Future<void> _enableScreenshot() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

}
