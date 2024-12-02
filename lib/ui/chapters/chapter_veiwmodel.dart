import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:education_media/ui/chapters/chapter_model.dart';
import 'package:flutter/material.dart';

class ChapterVeiwmodel extends ChangeNotifier{
List<Chapter>chapters=[];
  bool isLoadingchapters=true;

  Future<void> fetchChapters(String courseName) async {
    //  String encodedPath = "https://peproprep.edusuite.store/api/resource/Course Chapter"
    //     .replaceAll(" ","%20");
    final Uri url = Uri.parse("https://peproprep.edusuite.store/api/resource/Course%20Chapter");
    try {
       String credentials = "token 6e874616bdffac3:59a589ce127cc2a";

      final headers = {
        "Authorization": " $credentials",
        "x-secret-key": credentials,
        'Accept': 'application/json',
        "Content-Type": "application/json",
      };

      final response = await http.get(url,headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> chaptersData = data['data'] ?? [];
        chapters = chaptersData.map((json) => Chapter.fromJson(json)).toList();
      } else {
        print('Failed to load chapters. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching chapters: $e');
    }
    isLoadingchapters = false;
    notifyListeners();
  }
}