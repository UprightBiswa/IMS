// -----------------------------------------------------------------------------
// Controller (lib/app/modules/admin/leave_management/controllers/admin_leave_controller.dart)
// -----------------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../models/admin_leave_application_model.dart';
import '../models/admin_leave_summary_model.dart';

class AdminLeaveController extends GetxController {
  final ApiService _apiService = ApiService();
  final Logger _logger = Logger();

  final Rx<AdminLeaveSummaryModel?> leaveSummary = Rx<AdminLeaveSummaryModel?>(null);
  final RxList<AdminLeaveApplicationModel> leaveApplications = <AdminLeaveApplicationModel>[].obs;
  final RxBool isLoadingSummary = false.obs;
  final RxBool isLoadingApplications = false.obs;
  final RxBool isLoadMoreLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasMoreApplications = true.obs;

  int _currentPage = 1;
  final int _perPage = 10;
  final RxString selectedStatusFilter = 'all'.obs; // 'all', 'pending', 'approved', 'rejected'
  final RxString selectedLeaveTypeFilter = 'all'.obs; // 'all', 'sick', 'casual'
  final Rx<DateTimeRange?> selectedDateRangeFilter = Rx<DateTimeRange?>(null);
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchAdminLeaveSummary();
    fetchAdminLeaveApplications(isRefresh: true);
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.onClose();
  }

  void _onSearchChanged() {
    // Implement debounce for search to avoid too many API calls
    // For now, just trigger refresh
    // You might want to debounce this with a timer for better performance
    // if the API supports search by text.
    fetchAdminLeaveApplications(isRefresh: true);
  }

  Future<void> fetchAdminLeaveSummary() async {
    isLoadingSummary.value = true;
    errorMessage.value = '';
    try {
      // TODO: Replace with actual API call if available, otherwise use dummy
      // final response = await _apiService.get(ApiEndpoints.ADMIN_LEAVE_SUMMARY);
      // leaveSummary.value = AdminLeaveSummaryModel.fromJson(response.data);
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      leaveSummary.value = AdminLeaveSummaryModel.dummy();
    } catch (e) {
      errorMessage.value = 'Failed to load leave summary: ${e.toString()}';
      _logger.e(errorMessage.value);
    } finally {
      isLoadingSummary.value = false;
    }
  }

  Future<void> fetchAdminLeaveApplications({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      leaveApplications.clear();
      hasMoreApplications.value = true;
      isLoadingApplications.value = true;
      errorMessage.value = '';
    } else if (!hasMoreApplications.value) {
      return; // No more data to load
    }

    isLoadMoreLoading.value = !isRefresh; // Only set load more loading if not a refresh

    try {
      final Map<String, dynamic> queryParams = {
        'page': _currentPage,
        'per_page': _perPage,
      };

      if (selectedStatusFilter.value != 'all') {
        queryParams['status'] = selectedStatusFilter.value;
      }
      if (selectedLeaveTypeFilter.value != 'all') {
        queryParams['leave_type'] = selectedLeaveTypeFilter.value;
      }
      // Add date range filter if implemented in API
      if (selectedDateRangeFilter.value != null) {
        queryParams['start_date'] = DateFormat('yyyy-MM-dd').format(selectedDateRangeFilter.value!.start);
        queryParams['end_date'] = DateFormat('yyyy-MM-dd').format(selectedDateRangeFilter.value!.end);
      }
      // Add search query if implemented in API
      if (searchController.text.isNotEmpty) {
        queryParams['search'] = searchController.text;
      }

      final response = await _apiService.get(
        ApiEndpoints.ADMIN_ALL_LEAVE_APPLICATIONS, // New endpoint for admin all leaves
        queryParameters: queryParams,
      );

      final List<dynamic> applicationsJson = response.data['applications'];
      final List<AdminLeaveApplicationModel> fetchedApplications =
          applicationsJson.map((json) => AdminLeaveApplicationModel.fromJson(json)).toList();

      leaveApplications.addAll(fetchedApplications);
      if (fetchedApplications.length < _perPage) {
        hasMoreApplications.value = false;
      }
      _currentPage++;
    } on DioException catch (e) {
      String msg = 'Failed to load leave applications.';
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        msg = 'Connection timed out. Please check your internet connection or try again later.';
      } else if (e.response != null) {
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
        } else {
          msg = 'Server responded with status ${e.response?.statusCode} but no readable error message.';
        }
      } else {
        msg = e.message ?? 'Network error (No response from server).';
      }
      errorMessage.value = msg;
      _logger.e(errorMessage.value);
     Get.snackbar(
        'Error',
        msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha:0.8),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      _logger.e(errorMessage.value);
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha:0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoadingApplications.value = false;
      isLoadMoreLoading.value = false;
    }
  }

  void setStatusFilter(String status) {
    if (selectedStatusFilter.value != status) {
      selectedStatusFilter.value = status;
      fetchAdminLeaveApplications(isRefresh: true);
    }
  }

  void setLeaveTypeFilter(String type) {
    if (selectedLeaveTypeFilter.value != type) {
      selectedLeaveTypeFilter.value = type;
      fetchAdminLeaveApplications(isRefresh: true);
    }
  }

  void setDateRangeFilter(DateTimeRange? dateRange) {
    selectedDateRangeFilter.value = dateRange;
    fetchAdminLeaveApplications(isRefresh: true);
  }

  // Action for admin to approve/reject a leave application
  Future<void> reviewLeaveApplication(int applicationId, String action, {String? comments}) async {
    isLoadingApplications.value = true;
    errorMessage.value = '';
    try {
      final response = await _apiService.post(
        ApiEndpoints.ADMIN_REVIEW_LEAVE(applicationId), // Endpoint for review
        data: {
          'action': action, // 'approve' or 'reject'
          'comments': comments,
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Leave application ${action}d successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withValues(alpha:0.8),
          colorText: Colors.white,
        );
        // Refresh all data after review
        fetchAdminLeaveSummary();
        fetchAdminLeaveApplications(isRefresh: true);
      } else {
        Get.snackbar(
          'Info',
          'Review processed with status: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.withValues(alpha:0.8),
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      String msg = 'Failed to ${action} leave application.';
      if (e.response != null) {
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('message')) {
            msg = errorData['message'];
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
        backgroundColor: Colors.red.withValues(alpha:0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha:0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoadingApplications.value = false;
    }
  }
}