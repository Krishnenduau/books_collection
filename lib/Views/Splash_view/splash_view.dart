
import 'package:books_collection/Views/Splash_view/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController logic = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/splashlogo.png',
        width: 200, // Adjust the size of the logo as needed
        height: 200,
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SplashController>();
    super.dispose();
  }
}
