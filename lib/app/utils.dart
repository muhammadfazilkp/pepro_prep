import 'dart:io';

import 'package:education_media/constants/app_constants.dart';

String getDeviceType() {
  String deviceType = '';
  if (Platform.isAndroid) {
    deviceType = '1';
  } else if (Platform.isIOS) {
    deviceType = '2';
  }
  return deviceType;
}

String? validateEmail(String? value) {
  if (value?.isEmpty ?? true) {
    return "Email id is required";
  }
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value!)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$BASE_URL$endPoint');


  return url;
}


