import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../models/leave_application_model.dart';

class LeaveController extends GetxController {
  final ApiService _apiService = ApiService();

  // State for Leave Requests Screen
  final RxList<LeaveApplicationModel> leaveHistory =
      <LeaveApplicationModel>[].obs;
  final RxList<LeaveApplicationModel> pendingRequests =
      <LeaveApplicationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadMoreLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasMoreHistory = true.obs;
  final RxBool hasMorePending = true.obs;
  int _historyPage = 1;
  int _pendingPage = 1;
  final int _perPage = 10;

  // State for Apply Leave Screen
  final Rx<DateTimeRange?> selectedDateRange = Rx<DateTimeRange?>(null);
  final RxnString selectedLeaveType = RxnString();
  final TextEditingController reasonController = TextEditingController();
  final RxList<String> supportingDocuments =
      <String>[].obs; // Stores file names for now

  // Dummy list for leave types (as per API guide, sick and casual)
  final List<String> availableLeaveTypes = ['sick', 'casual'];

  @override
  void onInit() {
    super.onInit();
    fetchLeaveApplications(
      false,
      isRefresh: true,
    ); // Fetch initial Leave History
    fetchLeaveApplications(
      true,
      isRefresh: true,
    ); // Fetch initial Pending Requests
  }

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }

  Future<void> fetchLeaveApplications(
    bool isPending, {
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      if (isPending) {
        _pendingPage = 1;
        pendingRequests.clear();
        hasMorePending.value = true;
      } else {
        _historyPage = 1;
        leaveHistory.clear();
        hasMoreHistory.value = true;
      }
      isLoading.value = true;
      errorMessage.value = '';
    } else if ((isPending && !hasMorePending.value) ||
        (!isPending && !hasMoreHistory.value)) {
      return; // No more data to load
    }

    try {
      final String statusFilter = isPending
          ? 'pending'
          : 'all'; // 'all' for history
      final int page = isPending ? _pendingPage : _historyPage;

      final response = await _apiService.get(
        ApiEndpoints.STUDENT_LEAVE_APPLICATIONS,
        queryParameters: {
          'page': page,
          'per_page': _perPage,
          'status': statusFilter,
        },
      );

      final List<dynamic> applicationsJson = response.data['applications'];
      final List<LeaveApplicationModel> fetchedApplications = applicationsJson
          .map((json) => LeaveApplicationModel.fromJson(json))
          .toList();

      if (isPending) {
        pendingRequests.addAll(fetchedApplications);
        if (fetchedApplications.length < _perPage) {
          hasMorePending.value = false;
        }
        _pendingPage++;
      } else {
        leaveHistory.addAll(fetchedApplications);
        if (fetchedApplications.length < _perPage) {
          hasMoreHistory.value = false;
        }
        _historyPage++;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load leave applications: ${e.toString()}';
      print(errorMessage.value);
    } finally {
      isLoading.value = false;
      isLoadMoreLoading.value = false;
    }
  }

  Future<void> applyForLeave() async {
    if (selectedDateRange.value == null ||
        selectedLeaveType.value == null ||
        reasonController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields (Date Range, Leave Type, Reason).',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final String startDate = DateFormat(
        'yyyy-MM-dd',
      ).format(selectedDateRange.value!.start);
      final String endDate = DateFormat(
        'yyyy-MM-dd',
      ).format(selectedDateRange.value!.end);

      final response = await _apiService.post(
        ApiEndpoints.APPLY_LEAVE,
        data: {
          "leave_type": selectedLeaveType.value!.toLowerCase(),
          "start_date": startDate,
          "end_date": endDate,
          "reason": reasonController.text,
          "supporting_documents": supportingDocuments.toList(),
        },
      );

      print(response);

      if (response.statusCode == 201) {
        Get.snackbar(
          'Success',
          'Leave application submitted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
        resetApplyLeaveForm();
        // Refresh relevant lists
        fetchLeaveApplications(false, isRefresh: true); // Refresh history
        fetchLeaveApplications(true, isRefresh: true); // Refresh pending
        Get.back(); // Go back to leave requests screen
      } else {
        // Handle other successful but non-201 responses if needed
        Get.snackbar(
          'Info',
          'Leave application processed with status: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.withValues(alpha: 0.8),
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      String msg = 'Failed to submit leave application.';
      if (e.response != null) {
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('message')) {
            msg = errorData['message'];
          }
          if (errorData.containsKey('details') && errorData['details'] is Map) {
            final details = errorData['details'] as Map<String, dynamic>;
            if (details.containsKey('_schema') && details['_schema'] is List) {
              msg += ': ${(details['_schema'] as List).join(', ')}';
            }
          }
        }
      } else {
        msg = e.message ?? 'Network error';
      }
      errorMessage.value = msg;
      Get.snackbar(
        'Error',
        msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      print(e);
      errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetApplyLeaveForm() {
    selectedDateRange.value = null;
    selectedLeaveType.value = null;
    reasonController.clear();
    supportingDocuments.clear();
  }

  // Dummy file picker for now - just adds file name string
  Future<void> pickSupportingDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png'],
      allowMultiple: true,
    );

    if (result != null) {
      for (var file in result.files) {
        if (file.name != null && !supportingDocuments.contains(file.name!)) {
          supportingDocuments.add(file.name!);
        }
      }
    } else {
      // User canceled the picker
      print("File picking cancelled");
    }
  }
}
