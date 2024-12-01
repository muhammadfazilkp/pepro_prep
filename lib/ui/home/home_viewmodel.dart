import 'package:education_media/models/coursemodel.dart';
import 'package:education_media/service/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  HomeViewmodel({
    required Apiservice,
  }) : _apiservice = Apiservice;
  Coureses? coureses;
  // final LoginResponse loginResponse
  final Apiservice _apiservice;

  void init(){
    getUserDetails();
  }

  void getUserDetails(
      ) async {
    try {
      final courseData = await _apiservice.fetchCourseData(
        apikey: 'apikey',
        secretKey: 'secretKey',
      );
      debugPrint("Course Data: ${courseData.data?.title}");
    } catch (e) {
      debugPrint("Error fetching course data: $e");
    }
  }
}
