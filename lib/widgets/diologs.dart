import 'package:education_media/constants/app_constants.dart';
import 'package:education_media/service/navigation_service.dart';
import 'package:flutter/material.dart';

void showLogoutDialog(BuildContext context, Function onLogoutConfirmed) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Do you want to logout?'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
             navigationService.pushNamedAndRemoveUntil(RoutePaths.login);
              onLogoutConfirmed();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
