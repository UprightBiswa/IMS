// lib/app/modules/assignments/views/assignment_submit_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../../../../theme/app_colors.dart';
import '../../../../widgets/section_title.dart';
import '../controllers/assingment_controller.dart';
import '../models/assignment_model.dart';
import '../widgets/assignment_list_card.dart';
import 'assignment_create_new_tab.dart';

class AssignmentSubmitTab extends GetView<AssignmentController> {
  const AssignmentSubmitTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final dueSoonAssignments = controller.dueSoonAssignments;
      final submittedAssignments = controller.submittedAssignments;
      final overdueAssignments = controller.overdueAssignments;

      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overdue Assignments Section
              if (overdueAssignments.isNotEmpty) ...[
                const SectionTitle(title: 'Overdue Assignments'),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: overdueAssignments.length,
                  itemBuilder: (context, index) {
                    final assignment = overdueAssignments[index];
                    return AssignmentListCard(
                      assignment: assignment,
                      onTap: () {
                        // Navigate to AssignmentSubmissionScreen for overdue assignments
                        Get.to(() => AssignmentSubmissionScreen(assignment: assignment));
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],

              // Due Soon Assignments Section
              const SectionTitle(title: 'Assignments Due Soon'),
              const SizedBox(height: 12),
              if (dueSoonAssignments.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No assignments due soon. Keep up the good work!',
                        style: TextStyle(color: Colors.grey)),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dueSoonAssignments.length,
                  itemBuilder: (context, index) {
                    final assignment = dueSoonAssignments[index];
                    return AssignmentListCard(
                      assignment: assignment,
                      onTap: () {
                        // Navigate to AssignmentSubmissionScreen for due soon assignments
                        Get.to(() => AssignmentSubmissionScreen(assignment: assignment));
                      },
                    );
                  },
                ),
              const SizedBox(height: 24),

              // Submitted Assignments Section
              const SectionTitle(title: 'Submitted Assignments'),
              const SizedBox(height: 12),
              if (submittedAssignments.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No assignments submitted yet.',
                        style: TextStyle(color: Colors.grey)),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: submittedAssignments.length,
                  itemBuilder: (context, index) {
                    final assignment = submittedAssignments[index];
                    return AssignmentListCard(
                      assignment: assignment,
                      onTap: () {
                        // Navigate to AssignmentDetailsScreen for submitted assignments
                        Get.to(() => AssignmentDetailsScreen(assignment: assignment));
                      },
                    );
                  },
                ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
        // Remove or repurpose this FAB based on application flow.
        // If this FAB is for creating a brand new assignment (e.g., by a teacher), keep it.
        // If it's intended to trigger a submission, the flow above (tapping on an assignment) is more natural.
        // For now, I'm removing it as the UI provided is a submission form triggered by selecting an existing assignment.
        // If you still need a FAB for creating a *new* assignment (not submitting an existing one),
        // you would need a separate form for that, perhaps keeping a version of the old AssignmentCreateNewTab.
        /*
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.resetSubmissionForm(); // Clear form before opening
            Get.bottomSheet(
              // Using Get.bottomSheet for a consistent "New Assignment" experience
              AssignmentCreateNewTab(), // This is now AssignmentSubmissionScreen
              isScrollControlled: true, // Allows content to take full height
              backgroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            );
          },
          label: const Text('New Assignment', style: TextStyle(color: AppColors.white)),
          icon: const Icon(Icons.add, color: AppColors.white),
          backgroundColor: AppColors.primaryBlue, // Assuming primaryBlue exists
        ),
        */
      );
    });
  }
}

// Dummy AssignmentDetailsScreen for demonstration
class AssignmentDetailsScreen extends StatelessWidget {
  final Assignment assignment;
  const AssignmentDetailsScreen({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(assignment.title),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Subject: ${assignment.subject}', style: const TextStyle(fontSize: 16)),
            Text('Professor: ${assignment.professor}', style: const TextStyle(fontSize: 16)),
            Text('Due Date: ${DateFormat('MMM dd, hh:mm a').format(assignment.dueDate)}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Description:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(assignment.description.isNotEmpty ? assignment.description : 'No description provided.',
                style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 16),
            if (assignment.attachedFiles.isNotEmpty) ...[
              const Text('Attached Files:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ...assignment.attachedFiles.map((file) => Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text('- $file', style: const TextStyle(fontSize: 15, color: Colors.blue)),
                  )).toList(),
              const SizedBox(height: 16),
            ],
            Text('Status: ${assignment.status.name.capitalizeFirst}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: assignment.status == AssignmentStatus.submitted
                        ? Colors.green
                        : assignment.status == AssignmentStatus.overdue
                            ? Colors.red
                            : Colors.orange)),
            if (assignment.grade != null) ...[
              const SizedBox(height: 8),
              Text('Grade: ${assignment.grade}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
            if (assignment.feedback != null && assignment.feedback!.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text('Feedback:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(assignment.feedback!, style: const TextStyle(fontSize: 15)),
            ],
          ],
        ),
      ),
    );
  }
}