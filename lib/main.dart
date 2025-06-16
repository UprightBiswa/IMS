import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/modules/auth/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Fix: Disable edge-to-edge system UI on Android 15+
  if (Platform.isAndroid) {
    final androidVersion = int.parse(
      Platform.version.split(' ').first.split('.').first,
    );
    if (androidVersion >= 15) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.top],
      );
    }
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Inject AuthController with SharedPreferences
  Get.put<AuthController>(AuthController(prefs));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap
      },
      child: GetMaterialApp(
        title: "Attendance Management System",
        defaultTransition: Transition.cupertino,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,

        /// 👇 Add this to wrap every screen in SafeArea automatically
        builder: (context, child) {
          return SafeArea(
            top: true,
            bottom: true,
            child: child ?? const SizedBox(),
          );
        },
      ),
    );
  }
}
