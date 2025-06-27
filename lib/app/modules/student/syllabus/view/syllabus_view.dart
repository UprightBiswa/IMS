import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_drawer.dart';
import '../controllers/syllabus_controller.dart';
import 'tabs/exam_schedule_tab.dart';
import 'tabs/study_resources_tab.dart';
import 'tabs/syllabus_overview_tab.dart';

class SyllabusView extends GetView<SyllabusController> {
  const SyllabusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(title: 'Syllabus'),
      body: Obx(() {
        switch (controller.selectedTabIndex.value) {
          case 0:
            return SyllabusOverviewTab();
          case 1:
            return ExamScheduleTab();
          case 2:
            return StudyResourcesTab();
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
              _buildTabItem('Syllabus', 0),
              _buildTabItem('Exam Schedule', 1),
              _buildTabItem('Resources', 2),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTabItem(String label, int index) {
    final bool isSelected = controller.selectedTabIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
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
