// lib/app/modules/assignments/views/assignment_submission_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../../../../theme/app_colors.dart';
import '../controllers/assingment_controller.dart';
import '../models/assignment_model.dart'; // Import Assignment model
import '../widgets/assignment_list_card.dart'; // Re-using for the mini card

class AssignmentSubmissionScreen extends GetView<AssignmentController> {
  // It's crucial to pass the assignment being submitted
  final Assignment assignment;
  const AssignmentSubmissionScreen({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    // Initialize controller's submission data with the existing assignment details
    // This assumes the controller has methods to set these.
    // For now, we'll just display them from the 'assignment' object.

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textBlack),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Submit Assignment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: AppColors.textBlack),
            onPressed: () {
              // Handle saving as draft from app bar
              controller.saveAssignmentAsDraft();
            },
          ),
        ],
        backgroundColor: AppColors.white,
        elevation: 0, // No shadow
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mini Assignment Card - Matches the list item style
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.cardBackground, // Or a similar light background
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment.subject,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGray,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    assignment.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16, color: AppColors.textGray),
                      const SizedBox(width: 4),
                      Text(
                        'Prof. ${assignment.professor}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textGray,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: AppColors.textGray),
                      const SizedBox(width: 4),
                      Text(
                        'Due: ${DateFormat('MMM dd, hh:mm a').format(assignment.dueDate)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Assignment Details Section
            const Text(
              'Assignment Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Assignment Title',
              hint: 'e.g., Data Structures Homework',
              onChanged: controller.updateSubmissionTitle,
              initialValue: assignment.title, // Pre-fill with assignment title
              readOnly: true, // Title should not be editable by student
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Description / Comments',
              hint: 'Add any comments or notes about your submission...',
              onChanged: controller.updateSubmissionDescription,
              initialValue: controller.submissionDescription.value, // User's comments
              maxLines: 5, // More lines for comments
            ),
            const SizedBox(height: 24),

            // File Upload Section
            const Text(
              'File Upload',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.lightGrey),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Simulate file picking
                    Get.snackbar(
                      'File Upload',
                      'Simulating file selection...',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    // In a real app, integrate file_picker package
                    // For now, just add a dummy file
                    controller.addUploadedFile(
                        'assignment_document_${DateTime.now().millisecond}.pdf',
                        (DateTime.now().millisecondsSinceEpoch % 2000 + 500) / 1000); // Random MB size
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, color: AppColors.primaryBlue),
                        SizedBox(width: 12),
                        Text(
                          'Tap to select files',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Supported: PDF, DOC, DOCX, ZIP (Max 10MB)',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textGray,
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.uploadedFiles.length,
                itemBuilder: (context, index) {
                  final file = controller.uploadedFiles[index];
                  return _buildUploadedFileTile(
                    fileName: file.name,
                    fileSize: file.size,
                    onDelete: () => controller.removeUploadedFile(file.name),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Submission Confirmation Section
            const Text(
              'Submission Confirmation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
              ),
            ),
            const SizedBox(height: 16),
            _buildCheckbox(
              label: 'I confirm that this work is my own and I have not plagiarized any content. I understand the consequences of academic dishonesty.',
              value: controller.isOriginalWork,
              onChanged: controller.updateIsOriginalWork,
            ),
            _buildCheckbox(
              label: 'I have reviewed the assignment requirements and believe my submission meets all specified criteria.',
              value: controller.reviewedRequirements,
              onChanged: controller.updateReviewedRequirements,
            ),
            _buildCheckbox(
              label: 'This is my final submission for this assignment. I understand that late submissions may incur penalties.',
              value: controller.isFinalSubmission,
              onChanged: controller.updateIsFinalSubmission,
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Obx(() => Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.isSubmitting.value ? null : () => controller.saveAssignmentAsDraft(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryBlue,
                          side: const BorderSide(color: AppColors.primaryBlue),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Save as Draft'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.isSubmitting.value ? null : controller.submitAssignment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: controller.isSubmitting.value
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Submit Assignment',
                                style: TextStyle(color: AppColors.white),
                              ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    String? initialValue,
    int maxLines = 1,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          maxLines: maxLines,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryBlue),
            ),
            fillColor: AppColors.lightGrey.withOpacity(0.3),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadedFileTile({
    required String fileName,
    required double fileSize, // in MB
    required VoidCallback onDelete,
  }) {
    String extension = fileName.split('.').last.toUpperCase();
    IconData fileIcon;
    Color iconColor;

    switch (extension) {
      case 'PDF':
        fileIcon = Icons.picture_as_pdf;
        iconColor = Colors.red;
        break;
      case 'DOC':
      case 'DOCX':
        fileIcon = Icons.description;
        iconColor = Colors.blue;
        break;
      case 'ZIP':
        fileIcon = Icons.archive;
        iconColor = Colors.purple;
        break;
      default:
        fileIcon = Icons.insert_drive_file;
        iconColor = AppColors.textGray;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          Icon(fileIcon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${fileSize.toStringAsFixed(1)} MB',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGray,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox({
    required String label,
    required RxBool value,
    required Function(bool?) onChanged,
  }) {
    return Obx(
      () => CheckboxListTile(
        title: Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textBlack)),
        value: value.value,
        onChanged: onChanged,
        activeColor: AppColors.primaryBlue,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}