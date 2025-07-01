// lib/app/modules/assignments/views/assignment_calendar_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/assingment_controller.dart';
import 'assignment_calendar_list_tab.dart';
import 'assignment_calendar_overview_tab.dart';

class AssignmentCalendarTab extends GetView<AssignmentController> {
  const AssignmentCalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Internal Tab Bar for Calendar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCalendarSubTabItem('Month', 0),
              _buildCalendarSubTabItem('Agenda', 1),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            switch (controller.selectedCalendarTabIndex.value) {
              case 0:
                return const AssignmentCalendarOverviewTab();
              case 1:
                return const AssignmentCalendarListTab();
              default:
                return const Center(child: Text('Unknown Calendar Tab'));
            }
          }),
        ),
      ],
    );
  }

  Widget _buildCalendarSubTabItem(String label, int index) {
    return Obx(() {
      final bool isSelected =
          controller.selectedCalendarTabIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeCalendarTabIndex(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.primaryBlue,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      );
    });
  }
}
