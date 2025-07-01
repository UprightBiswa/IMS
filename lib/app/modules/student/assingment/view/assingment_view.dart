// lib/app/modules/assignments/views/assignment_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_drawer.dart';
import '../controllers/assingment_controller.dart';
import 'assignment_overview_tab.dart';
import 'assignment_submit_tab.dart'; // This will handle both due soon and submitted lists
import 'assignment_calendar_tab.dart'; // New Calendar tab

class AssignmentView extends GetView<AssignmentController> {
  const AssignmentView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the controller is initialized
    if (!Get.isRegistered<AssignmentController>()) {
      Get.put(AssignmentController());
    }

    return Scaffold(
      drawer: const CustomDrawer(), // Assuming CustomDrawer exists
      appBar: const CustomAppBar(title: 'Assignments'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage.value}'));
        }
        // Body content changes based on selected tab index
        switch (controller.selectedAssignmentTabIndex.value) {
          case 0:
            return const AssignmentOverviewTab();
          case 1:
            return const AssignmentSubmitTab(); // This tab now shows Due Soon and Submitted lists
          case 2:
            return const AssignmentCalendarTab(); // Handles internal calendar tabs
          default:
            return const Center(child: Text('Unknown Tab'));
        }
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12), // Adjusted padding
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), // Fixed opacity usage
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTabItem('Overview', 0),
              _buildTabItem('Submit', 1),
              _buildTabItem('Calendar', 2),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTabItem(String label, int index) {
    final bool isSelected =
        controller.selectedAssignmentTabIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeAssignmentTabIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryBlue
              : Colors
                    .transparent, // Assuming primaryBlue is defined in AppColors
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primaryBlue,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
