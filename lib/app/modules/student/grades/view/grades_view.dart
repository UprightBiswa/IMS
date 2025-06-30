import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_drawer.dart';
import '../controllers/grades_controller.dart';
import 'grades_calendar_tab.dart';
import 'grades_exams_tab.dart';
import 'grades_overview_tab.dart';
import 'grades_results_tab.dart';

class GradesView extends GetView<GradesController> {
  const GradesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(title: 'Grades'),
      body: Obx(() {
        // Body content changes based on selected tab index
        switch (controller.selectedGradesTabIndex.value) {
          case 0:
            return const GradesOverviewTab();
          case 1:
            return const GradesCalendarTab();
          case 2:
            return const GradesExamsTab();
          case 3:
            return const GradesResultsTab();
          default:
            return const Center(child: Text('Unknown Tab'));
        }
      }),
      bottomNavigationBar: Obx(() {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: .1),
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
              _buildTabItem('Calendar', 1),
              _buildTabItem('Exams', 2),
              _buildTabItem('Results', 3),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTabItem(String label, int index) {
    final bool isSelected = controller.selectedGradesTabIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeGradesTabIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
  }
}
