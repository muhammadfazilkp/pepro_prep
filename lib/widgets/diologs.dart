import 'dart:math';

import 'package:flutter/material.dart';

void showLogoutDialog(BuildContext context,  VoidCallback onLogoutConfirmed) {
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
              Navigator.of(context).pop();
            onLogoutConfirmed();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
