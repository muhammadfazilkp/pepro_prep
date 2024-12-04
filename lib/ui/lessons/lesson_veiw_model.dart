import 'dart:convert';
import 'dart:io';

import 'package:education_media/models/lesson_details_model.dart';
import 'package:education_media/ui/lessons/lesson_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:http/http.dart'as http;
class LessonDetailsViewModel extends ChangeNotifier {
  bool isLoading = true;
  LessonDetails? lessonDetails;



void init ()async{
_disableScreenshot();
}
  Future<void> fetchLessonDetails(String lessonName) async {
    String encodedLessonName = Uri.encodeComponent(lessonName);
    final Uri url = Uri.parse(
      'https://peproprep.edusuite.store/api/resource/Course%20Lesson/$encodedLessonName',
    );
//  final url = Uri.parse(
//         "https://peproprep.edusuite.store/api/resource/Course%20Lesson/$lessonName");
    debugPrint("URL : $url");
    try {
      String credentials = "token 6e874616bdffac3:59a589ce127cc2a";

      final headers = {
        "Authorization": " $credentials",
        "x-secret-key": credentials,
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };

      final response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        lessonDetails = LessonDetails.fromJson(data);
      } else {
        print('Failed to load lesson details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching lesson details: $e');
    }

    isLoading = false;
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
}
