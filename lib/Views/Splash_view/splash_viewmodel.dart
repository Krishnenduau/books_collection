import 'package:books_collection/Views/Books_list/book_list_view.dart';
import 'package:books_collection/Constant/app_routs.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';


class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      // Example: navigate to home after delay
      Get.offNamed(AppRoutes.home);
    });
  }
}

