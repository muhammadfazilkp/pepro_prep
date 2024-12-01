import 'package:education_media/app/utils.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'course_model.dart'; // Import the model file

class CatogoryViewModel extends ChangeNotifier {
  List<Course> liveCourses = [];
  bool isLoading = true;

  Future<void> fetchLiveCourses() async {
    Uri url=buildBaseUrl('lms.lms.utils.get_courses');
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
}
