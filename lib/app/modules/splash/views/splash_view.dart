// lib/app/modules/splash/views/splash_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/controllers/auth_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger handleInitialScreen after the splash duration
    Future.delayed(const Duration(seconds: 2), () {
      Get.find<AuthController>().handleInitialScreen();
    });

    return const Scaffold(
      body: Center(
        // You can put your app logo or animation here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}