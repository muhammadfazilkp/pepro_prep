import 'dart:convert';

import 'package:education_media/models/coursemodel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Apiservice extends ChangeNotifier {
  Future<Coureses> fetchCourseData(
      {required String apikey, required String secretKey}) async {
    final url = Uri.parse(
        "https://peproprep.edusuite.store/api/resource/Course Lesson/0006 test001");

    try {
      String credentials = "$apikey:$secretKey";
      String basicAuth = "Basic ${base64Encode(utf8.encode(credentials))}";
      final response = await http.get(
        url,
        headers: {
          "Authorization": "token $credentials",
          // "x-secret-key": secretKey,
          // "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Coureses.fromJson(jsonResponse);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
