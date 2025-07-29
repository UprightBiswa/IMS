import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../widgets/quick_link_section.dart';
import '../widgets/summary_horizontal_section.dart';
import '../widgets/today_classes_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      body: Obx(() {
        final user = authController.currentUser.value;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back, ${authController.currentUser.value?.name ?? 'User'}!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Here's everything you need to know for today.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGray,
                ),
              ),
              SizedBox(height: 24),
              TodaysClassesSection(),
              SizedBox(height: 24),
              SummaryHorizontalSection(),
              SizedBox(height: 24),
              QuickLinksSection(),
            ],
          ),
        );
      }),
    );
  }
}
