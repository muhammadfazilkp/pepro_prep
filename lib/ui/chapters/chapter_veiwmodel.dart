import 'dart:convert';
import 'dart:io';
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

 Future<void> init() async {
  await  _disableScreenshot();
  await  getKeys();
  }

 Future<void> getKeys() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loginKey = pref.getString('loginKey');
    loginSecretKey = pref.getString('loginSecretKey');
    notifyListeners();
  }

  Future<void> fetchChapters(String courseName) async {
    //  String encodedPath = "https://peproprep.edusuite.store/api/resource/Course Chapter"
    //     .replaceAll(" ","%20");
 if (loginKey == null || loginSecretKey == null) {
      debugPrint('Keys are not available. Fetching keys...');
      await getKeys(); // Ensure keys are loaded before making the API call
    }
    final Uri url = Uri.parse(
        "https://peproprep.edusuite.store/api/resource/Course%20Chapter");
    try {
      String credentials = "token $loginKey:$loginSecretKey";

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
  if (Platform.isAndroid) {
    try {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } catch (e) {
      debugPrint('Error disabling screenshots: $e');
    }
  }
}

   Future<void> _enableScreenshot() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

}
