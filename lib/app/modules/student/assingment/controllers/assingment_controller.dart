// lib/app/modules/assignments/controllers/assingment_controller.dart
import 'package:get/get.dart';
import '../models/assignment_model.dart';
import '../models/assignment_summary_model.dart';

// Assuming you have this model for uploaded files in assignment_model.dart
class UploadedFile {
  final String name;
  final double size; // Size in MB

  UploadedFile({required this.name, required this.size});
}

class AssignmentController extends GetxController {
  // Tab Management
  final RxInt selectedAssignmentTabIndex = 0.obs;
  final RxInt selectedCalendarTabIndex =
      0.obs; // New: For Calendar tab's internal tabs

  void changeAssignmentTabIndex(int index) {
    selectedAssignmentTabIndex.value = index;
    if (index == 2) {
      // Reset calendar tab index when navigating to it
      selectedCalendarTabIndex.value = 0;
    }
  }

  void changeCalendarTabIndex(int index) {
    // New: For Calendar tab's internal tabs
    selectedCalendarTabIndex.value = index;
  }

  // Data Observables
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final Rx<AssignmentSummaryModel?> assignmentSummary =
      Rx<AssignmentSummaryModel?>(null);
  final RxList<Assignment> allAssignments = <Assignment>[].obs;
  final RxList<Assignment> dueSoonAssignments = <Assignment>[].obs;
  final RxList<Assignment> submittedAssignments = <Assignment>[].obs;
  final RxList<Assignment> overdueAssignments =
      <Assignment>[].obs; // New: For overdue

  // --- Form fields for submission ---
  final RxString submissionTitle = ''.obs;
  final RxString submissionSubject = ''.obs;
  final RxString submissionProfessor = ''.obs;
  final Rx<DateTime?> submissionDueDate = Rx<DateTime?>(null);
  final RxString submissionDescription =
      ''.obs; // This will be the student's comments
  final RxList<UploadedFile> uploadedFiles =
      <UploadedFile>[].obs; // To store name and size
  final RxBool isOriginalWork = false.obs;
  final RxBool reviewedRequirements = false.obs;
  final RxBool isFinalSubmission = false.obs;
  final RxBool isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAssignmentData();
  }

  Future<void> _fetchAssignmentData() async {
    try {
      isLoading(true);
      errorMessage('');

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Populate dummy data
      assignmentSummary.value = AssignmentSummaryModel.dummy();
      allAssignments.assignAll(Assignment.dummyList());

      // Filter assignments for tabs
      _filterAssignments();
    } catch (e) {
      errorMessage('Failed to load assignments: $e');
      Get.snackbar('Error', 'Failed to load assignment data.');
    } finally {
      isLoading(false);
    }
  }

  void _filterAssignments() {
    final now = DateTime.now();
    dueSoonAssignments.clear();
    submittedAssignments.clear();
    overdueAssignments.clear();

    for (var assignment in allAssignments) {
      if (assignment.status == AssignmentStatus.submitted ||
          assignment.status == AssignmentStatus.graded) {
        submittedAssignments.add(assignment);
      } else if (assignment.dueDate.isBefore(now) &&
          assignment.status != AssignmentStatus.submitted) {
        overdueAssignments.add(assignment);
      } else if (assignment.dueDate.isAfter(now) &&
          assignment.dueDate.difference(now).inDays <= 7) {
        dueSoonAssignments.add(assignment);
      }
    }
    // Sort due soon assignments by due date
    dueSoonAssignments.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    // Sort submitted assignments by due date (or submission date if available)
    submittedAssignments.sort((a, b) => b.dueDate.compareTo(a.dueDate));
    // Sort overdue assignments by due date
    overdueAssignments.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  // --- Submission Form Logic ---
  void updateSubmissionTitle(String title) {
    submissionTitle.value = title;
  }

  void updateSubmissionSubject(String subject) {
    submissionSubject.value = subject;
  }

  void updateSubmissionProfessor(String professor) {
    submissionProfessor.value = professor;
  }

  void updateSubmissionDueDate(DateTime? date) {
    submissionDueDate.value = date;
  }

  void updateSubmissionDescription(String description) {
    submissionDescription.value = description;
  }

  void addUploadedFile(String fileName, double fileSize) {
    uploadedFiles.add(UploadedFile(name: fileName, size: fileSize));
  }

  void removeUploadedFile(String fileName) {
    uploadedFiles.removeWhere((file) => file.name == fileName);
  }

  void updateIsOriginalWork(bool? value) {
    isOriginalWork.value = value ?? false;
  }

  void updateReviewedRequirements(bool? value) {
    reviewedRequirements.value = value ?? false;
  }

  void updateIsFinalSubmission(bool? value) {
    isFinalSubmission.value = value ?? false;
  }

  Future<void> saveAssignmentAsDraft() async {
    Get.snackbar(
      'Draft Saved',
      'Assignment "${submissionTitle.value}" saved as draft.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> submitAssignment() async {
    if (isSubmitting.value) return;

    if (submissionTitle.value.isEmpty ||
        submissionSubject.value.isEmpty ||
        submissionProfessor.value.isEmpty ||
        submissionDueDate.value == null ||
        !isOriginalWork.value ||
        !reviewedRequirements.value ||
        !isFinalSubmission.value) {
      Get.snackbar(
        'Error',
        'Please fill all required fields and confirm all checkboxes.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    isSubmitting(true);
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      final newAssignment = Assignment(
        id: 'A${allAssignments.length + 1}',
        title: submissionTitle.value,
        subject: submissionSubject.value,
        professor: submissionProfessor.value,
        dueDate: submissionDueDate.value!,
        description: submissionDescription.value,
        attachedFiles: uploadedFiles.map((file) => file.name).toList(),
        status: AssignmentStatus.submitted, // Mark as submitted
      );

      allAssignments.add(newAssignment);
      _filterAssignments(); // Re-filter assignments to update lists
      resetSubmissionForm();
      Get.snackbar(
        'Success',
        'Assignment "${newAssignment.title}" submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      changeAssignmentTabIndex(1); // Navigate to Submit/Submitted tab
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit assignment: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isSubmitting(false);
    }
  }

  void resetSubmissionForm() {
    submissionTitle.value = '';
    submissionSubject.value = '';
    submissionProfessor.value = '';
    submissionDueDate.value = null;
    submissionDescription.value = '';
    uploadedFiles.clear();
    isOriginalWork.value = false;
    reviewedRequirements.value = false;
    isFinalSubmission.value = false;
  }

  void downloadAssignmentReport() {
    Get.snackbar(
      'Download Report',
      'Simulating download of assignment report.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
