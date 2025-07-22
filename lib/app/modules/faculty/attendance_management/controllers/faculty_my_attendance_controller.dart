import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../../../../theme/app_colors.dart';
import '../models/faculty_attendance_log_model.dart';
import '../models/faculty_attendance_model.dart';
import '../models/faculty_checkin_model.dart';
import '../models/leave_balance_model.dart';
import '../models/leave_request_model.dart';

class FacultyMyAttendanceController extends GetxController {
  final ApiService _apiService = ApiService();
  final Logger _logger = Logger();
  // Tabs
  final RxInt selectedSubTab = 0.obs;

  // Loading/Error
  final RxBool isLoading = true.obs;
  final RxBool isError = false.obs;
  final RxString errorMessage = ''.obs;

  // Attendance Data
  final Rx<MonthlyAttendanceSummary?> monthlySummary =
      Rx<MonthlyAttendanceSummary?>(null);
  final RxString calendarMonthYear = ''.obs;
  final RxList<CalendarDayStatus> calendarDays = <CalendarDayStatus>[].obs;
  final RxList<RecentActivity> recentActivities = <RecentActivity>[].obs;

  // Leave Data
  final Rx<LeaveBalance?> leaveBalance = Rx<LeaveBalance?>(null);
  final RxList<LeaveRequest> leaveApplications = <LeaveRequest>[].obs;

  // Apply Leave Fields
  final Rx<DateTime?> selectedLeaveStartDate = Rx<DateTime?>(null);
  final Rx<DateTime?> selectedLeaveEndDate = Rx<DateTime?>(null);
  final RxString selectedLeaveType = ''.obs;
  final RxString leaveReason = ''.obs;
  final RxBool isSingleDayLeave = true.obs;
  final RxList<String> leaveTypes = <String>[
    'Sick Leave',
    'Casual Leave',
    'Earned Leave',
    'Maternity Leave',
    'Paternity Leave',
    'Study Leave',
    'Bereavement Leave',
    'Duty Leave',
  ].obs;


  // NEW: Check In Data (Check In Tab)
  final Rx<FacultyCheckInStatus?> checkInStatus = Rx<FacultyCheckInStatus?>(null);
  final RxString currentTime = ''.obs;
  Timer? _timer;

  // NEW: Attendance Log Data (Log Tab)
  final RxList<AttendanceLogEntry> attendanceLogs = <AttendanceLogEntry>[].obs;
  final RxBool isLoadingLogs = false.obs;
  final RxBool hasMoreLogs = true.obs;
  final RxBool isLoadMoreLoading = false.obs;
  int _logCurrentPage = 1;
  final int _logPerPage = 10;
  final TextEditingController logSearchController = TextEditingController();
  final RxString selectedLogStatusFilter = 'All'.obs; // 'All', 'Present', 'Absent', 'Late', 'Leave'
  final Rx<DateTimeRange?> selectedLogDateRangeFilter = Rx<DateTimeRange?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchMyAttendanceData();
    fetchLeaveDashboardData();
      _startClock(); // For Check In Tab
    fetchAttendanceLogs(isRefresh: true); // For Log Tab
    logSearchController.addListener(_onLogSearchChanged);
  }
@override
  void onClose() {
    _timer?.cancel();
    logSearchController.removeListener(_onLogSearchChanged);
    logSearchController.dispose();
    super.onClose();
  }
  // void changeSubTab(int index) => selectedSubTab.value = index;
void changeSubTab(int index) {
    selectedSubTab.value = index;
    // Potentially trigger data fetch for new tabs if not already fetched
    if (index == 1 && checkInStatus.value == null) {
      // fetchCheckInStatus(); // If you have a dedicated API for this
    } else if (index == 2 && attendanceLogs.isEmpty) {
      fetchAttendanceLogs(isRefresh: true);
    }
  }

  void toggleLeaveType(bool isSingleDay) {
    isSingleDayLeave.value = isSingleDay;
    if (isSingleDay) {
      selectedLeaveEndDate.value = selectedLeaveStartDate.value;
    }
  }

  void updateLeaveReason(String value) => leaveReason.value = value;

  void submitLeaveRequest() {
    if (selectedLeaveStartDate.value == null ||
        selectedLeaveType.isEmpty ||
        leaveReason.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields for leave application.',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
      return;
    }

    // TODO: Implement actual API call for submitting leave request
    _logger.i('Submitting leave request:');
    _logger.i('Start Date: ${selectedLeaveStartDate.value}');
    _logger.i('End Date: ${selectedLeaveEndDate.value}');
    _logger.i('Leave Type: ${selectedLeaveType.value}');
    _logger.i('Reason: ${leaveReason.value}');

    Get.back(); // Close modal
    Get.snackbar(
      'Success',
      'Leave request submitted successfully!',
      backgroundColor: Get.theme.colorScheme.secondary,
      colorText: Get.theme.colorScheme.onSecondary,
    );

    // Reset form
    selectedLeaveStartDate.value = null;
    selectedLeaveEndDate.value = null;
    selectedLeaveType.value = '';
    leaveReason.value = '';
    isSingleDayLeave.value = true;
     fetchLeaveDashboardData(); 
  }

  Future<void> fetchMyAttendanceData() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final response = await _apiService.get(
        ApiEndpoints.FACULTY_ATTENDANCE_MAPP,
      );

      final data = response.data['data']['faculty_data'];

      // Parse monthly summary
      monthlySummary.value = MonthlyAttendanceSummary.fromJson(
        data['monthly_attendance_widget'],
      );

      final calendarJson = data['calendar_data'];

      // Parse calendar
      calendarDays.value = (calendarJson['data'] as List)
          .map((e) => CalendarDayStatus.fromJson(e))
          .toList();

      calendarMonthYear.value = calendarJson['month_year'] ?? '';

      recentActivities.value = RecentActivity.dummyList();
    } catch (e) {
      isError.value = true;
      errorMessage.value = e.toString();
            _logger.e('Error fetching my attendance data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  //leave
  Future<void> fetchLeaveDashboardData() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final response = await _apiService.get(
        ApiEndpoints.FACULTY_LEAVE_DASHBOARD_MAPP,
      );

      final data = response.data['data']['faculty_data'];

      leaveBalance.value = LeaveBalance.fromJson(data['leave_balance']);

      leaveApplications.value = (data['recent_leave_applications'] as List)
          .map((e) => LeaveRequest.fromJson(e))
          .toList();
    } catch (e) {
      isError.value = true;
      errorMessage.value = 'Leave data error: ${e.toString()}';
       _logger.e('Error fetching leave dashboard data: $e');
    } finally {
      isLoading.value = false;
    }
  }
// NEW: Check In/Out Logic
  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime.value = DateFormat('EEEE, MMM d, yyyy\nhh:mm:ss a').format(DateTime.now());
    });
  }

  Future<void> checkIn() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Simulate API call for check-in
      await Future.delayed(const Duration(seconds: 1));
      checkInStatus.value = FacultyCheckInStatus.dummyCheckedIn();
      Get.snackbar(
        'Success',
        'Checked In Successfully!',
        backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      // TODO: Call actual API: await _apiService.post(ApiEndpoints.FACULTY_CHECK_IN, {});
    } catch (e) {
      errorMessage.value = 'Failed to check in: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkOut() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Simulate API call for check-out
      await Future.delayed(const Duration(seconds: 1));
      checkInStatus.value = FacultyCheckInStatus.dummyCheckedOut();
      Get.snackbar(
        'Success',
        'Checked Out Successfully!',
        backgroundColor: AppColors.primaryGreen.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      // TODO: Call actual API: await _apiService.post(ApiEndpoints.FACULTY_CHECK_OUT, {});
    } catch (e) {
      errorMessage.value = 'Failed to check out: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // NEW: Attendance Log Logic
  void _onLogSearchChanged() {
    // Implement debounce for search if needed
    fetchAttendanceLogs(isRefresh: true);
  }

  void setLogStatusFilter(String status) {
    if (selectedLogStatusFilter.value != status) {
      selectedLogStatusFilter.value = status;
      fetchAttendanceLogs(isRefresh: true);
    }
  }

  void setLogDateRangeFilter(DateTimeRange? dateRange) {
    selectedLogDateRangeFilter.value = dateRange;
    fetchAttendanceLogs(isRefresh: true);
  }

  Future<void> fetchAttendanceLogs({bool isRefresh = false}) async {
    if (isRefresh) {
      _logCurrentPage = 1;
      attendanceLogs.clear();
      hasMoreLogs.value = true;
      isLoadingLogs.value = true;
      errorMessage.value = '';
    } else if (!hasMoreLogs.value) {
      return;
    }

    isLoadMoreLoading.value = !isRefresh;

    try {
      // Simulate API call for attendance logs
      await Future.delayed(const Duration(seconds: 1));
      final List<AttendanceLogEntry> fetched = AttendanceLogEntry.dummyList(); // Use dummy data

      // Apply filters to dummy data (for demonstration)
      List<AttendanceLogEntry> filtered = fetched.where((log) {
        bool statusMatch = selectedLogStatusFilter.value == 'All' ||
            log.status.toLowerCase() == selectedLogStatusFilter.value.toLowerCase();

        bool dateMatch = true;
        if (selectedLogDateRangeFilter.value != null) {
          final start = selectedLogDateRangeFilter.value!.start;
          final end = selectedLogDateRangeFilter.value!.end;
          dateMatch = (log.date.isAtSameMomentAs(start) || log.date.isAfter(start)) &&
                      (log.date.isAtSameMomentAs(end) || log.date.isBefore(end));
        }

        bool searchMatch = true;
        if (logSearchController.text.isNotEmpty) {
          final query = logSearchController.text.toLowerCase();
          searchMatch = log.status.toLowerCase().contains(query) ||
                        (log.note?.toLowerCase().contains(query) ?? false) ||
                        log.date.toString().toLowerCase().contains(query);
        }
        return statusMatch && dateMatch && searchMatch;
      }).toList();

      // Simulate pagination on filtered dummy data
      final int startIndex = (_logCurrentPage - 1) * _logPerPage;
      final int endIndex = startIndex + _logPerPage;
      final paginated = filtered.sublist(
        startIndex,
        endIndex > filtered.length ? filtered.length : endIndex,
      );

      attendanceLogs.addAll(paginated);
      if (paginated.length < _logPerPage || endIndex >= filtered.length) {
        hasMoreLogs.value = false;
      }
      _logCurrentPage++;

      // TODO: Replace with actual API call:
      // final response = await _apiService.get(
      //   ApiEndpoints.FACULTY_ATTENDANCE_LOGS, // Define this endpoint
      //   queryParameters: {
      //     'page': _logCurrentPage,
      //     'per_page': _logPerPage,
      //     'status': selectedLogStatusFilter.value,
      //     'start_date': selectedLogDateRangeFilter.value?.start.toIso8601String(),
      //     'end_date': selectedLogDateRangeFilter.value?.end.toIso8601String(),
      //     'search': logSearchController.text,
      //   },
      // );
      // final List<dynamic> logsJson = response.data['logs'];
      // final List<AttendanceLogEntry> fetched = logsJson.map((json) => AttendanceLogEntry.fromJson(json)).toList();
      // attendanceLogs.addAll(fetched);
      // if (fetched.length < _logPerPage) {
      //   hasMoreLogs.value = false;
      // }
      // _logCurrentPage++;
    } on DioException catch (e) {
      String msg = 'Failed to load attendance logs.';
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        msg = 'Connection timed out. Please check your internet connection or try again later.';
      } else if (e.response != null) {
        final errorData = e.response!.data;
        if (errorData is Map<String, dynamic>) {
          if (errorData.containsKey('message')) {
            msg = errorData['message'];
          }
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
        backgroundColor: Colors.red.withValues(alpha: 0.8),
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
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoadingLogs.value = false;
      isLoadMoreLoading.value = false;
    }
  }
}
