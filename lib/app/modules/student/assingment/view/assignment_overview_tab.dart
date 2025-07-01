// lib/app/modules/assignments/views/assignment_overview_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/section_title.dart';
import '../controllers/assingment_controller.dart';
import '../widgets/assignment_summary_card.dart';
import '../widgets/assignment_timeline_chart.dart';
import '../widgets/subject_assignment_card.dart'; // Widget for subject breakdown

class AssignmentOverviewTab extends GetView<AssignmentController> {
  const AssignmentOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure the controller is initialized
    if (!Get.isRegistered<AssignmentController>()) {
      Get.put(AssignmentController());
    }

    return Obx(() {
      if (controller.assignmentSummary.value == null) {
        return const Center(child: CircularProgressIndicator()); // Show loading indicator
      }

      final summary = controller.assignmentSummary.value!;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Assignment Progress
            AssignmentSummaryCard(summary: summary),
            const SizedBox(height: 24),

            // Subject-wise Assignment Breakdown
            const SectionTitle(title: 'Subject-wise Assignment Breakdown'),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: summary.subjectBreakdowns.length,
              itemBuilder: (context, index) {
                final breakdown = summary.subjectBreakdowns[index];
                return SubjectAssignmentCard(breakdown: breakdown);
              },
            ),

            const SizedBox(height: 24),

            // Recommended Actions
            const SectionTitle(title: 'Recommended Actions'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warningBg.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.warningBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: summary.recommendedActions.map((action) => Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(action, style: const TextStyle(fontSize: 14)),
                )).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Assignment Timeline Chart
            AssignmentTimelineChart(timelineData: summary.assignmentTimelineData),
            const SizedBox(height: 24),

            // Download Report Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.downloadAssignmentReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Download Assignment Report',
                  style: TextStyle(fontSize: 16, color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}