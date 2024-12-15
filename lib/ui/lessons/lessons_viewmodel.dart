import 'dart:convert';

import 'package:education_media/ui/lessons/lessons_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
// class LessonsViewmodel extends ChangeNotifier{

//   List<Lesson> lessons = [];
//   bool isLoadingLessons = true;

//   Future<void> fetchLessons(String chapterName) async {
//     final Uri url = Uri.parse('https://peproprep.edusuite.store/api/resource/Course%20Lesson$chapterName');
//     try {
//       String credentials = "token 6e874616bdffac3:59a589ce127cc2a";

//       final headers = {
//         "Authorization": " $credentials",
//         "x-secret-key": credentials,
//         'Accept': 'application/json',
//         "Content-Type": "application/json",
//       };
//       final response = await http.get(url,headers:headers );
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final List<dynamic> lessonsData = data['data'] ?? [];
//         lessons = lessonsData.map((json) => Lesson.fromJson(json)).toList();
//       } else {
//         print('Failed to load lessons. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching lessons: $e');
//     }
//     isLoadingLessons = false;
//     notifyListeners();
//   }
// }

class LessonViewModel extends ChangeNotifier {

   String? loginKey;
  String? loginSecretKey;
  ChapterWithLessons? chapterWithLessons;
  bool isLoadingLessons = true;
Future<void> init() async {
  // await  _disableScreenshot();
  await  getKeys();
  }

 Future<void> getKeys() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    loginKey = pref.getString('loginKey');
    loginSecretKey = pref.getString('loginSecretKey');
    notifyListeners();
  }
  Future<void> fetchLessons(String chapterName) async {
    String encodedChapterName=Uri.encodeComponent(chapterName);
    String encodedPath = "https://peproprep.edusuite.store/api/resource/Course%20Chapter/$encodedChapterName";

print(encodedPath);
    final Uri url = Uri.parse(
      encodedPath
    );
    try {
       String credentials = "token $loginKey:$loginSecretKey";

      final headers = {
        "Authorization": " $credentials",
        "x-secret-key": credentials,
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };
      final response = await http.get(url,headers:headers);
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        chapterWithLessons = ChapterWithLessons.fromJson(data);
      } else {
        print('Failed to load lessons. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching lessons: $e');
    }
    isLoadingLessons = false;
    notifyListeners();
  }
}
