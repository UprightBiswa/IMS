import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_colors.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: controller.skipOnboarding,
                child: const Text(
                  'Skip',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  OnboardingPage(
                    title: 'Connect with Peers',
                    description:
                        'Stay connected with classmates, join study groups, and collaborate on projects seamlessly.',
                    icon: Icons.group,
                  ),
                  OnboardingPage(
                    title: 'Track Performance',
                    description:
                        'Monitor your grades, attendance, and get insights to improve your academic performance.',
                    icon: Icons.bar_chart,
                  ),
                  OnboardingPage(
                    title: 'Stay Updated',
                    description:
                        'Get real-time notifications about assignments, exams, announcements, and important updates.',
                    icon: Icons.notifications,
                  ),
                ],
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3, // Number of onboarding pages
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: controller.currentPage.value == index ? 24.0 : 8.0,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? AppColors.white
                          : AppColors.grey,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Visibility(
                      visible: controller.currentPage.value > 0,
                      child: Expanded(
                        child: ElevatedButton(
                          onPressed: controller.previousPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white.withValues(
                              alpha: .2,
                            ),
                            foregroundColor: AppColors.grey,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),

                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppColors.white.withValues(alpha: .30),
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: const Text('Previous'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Obx(
                        () => Text(
                          controller.currentPage.value == 2
                              ? 'Get Started'
                              : 'Next',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon; // Using IconData for the small icons as in the image

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // This part of the UI is fixed on all three onboarding screens
          // IMS Logo/Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'IMS',
                style: TextStyle(
                  color: Color(0xFF3F51B5), // Blue color for text
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Welcome to Institute Portal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            'Your complete academic management solution',
            style: TextStyle(fontSize: 16, color: AppColors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          // Dynamic icon for each page
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: .2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 60, color: AppColors.white),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: AppColors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
