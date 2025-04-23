// lib/utils/snackbar_helper.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarMessage {
  static void show(
    String message, {
    String title = 'Message',
    Color titleColor = Colors.black,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color.fromARGB(221, 213, 210, 210),
      colorText: Colors.black, // Set message text color to black
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      titleText: Text(
        title,
        style: TextStyle(color: titleColor), // Title color customization
      ),
    );
  }
}
