import 'dart:convert';

import 'package:education_media/models/coursemodel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Apiservice extends ChangeNotifier {
  Future<Coureses> fetchCourseData(
       {required String apikey, required String secretKey}
      ) async {
    final url = Uri.parse(
        "https://peproprep.edusuite.store/api/resource/Course%20Lesson/0006%20test001");
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
      debugPrint('Response----> $response');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return Coureses.fromJson(jsonResponse);
      } else {
        debugPrint('Failed with status code: ${response.statusCode}');
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
