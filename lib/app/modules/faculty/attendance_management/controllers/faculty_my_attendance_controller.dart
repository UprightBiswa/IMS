import 'package:get/get.dart';
import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../models/faculty_attendance_model.dart';
import '../models/leave_balance_model.dart';
import '../models/leave_request_model.dart';

class FacultyMyAttendanceController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    fetchMyAttendanceData();
    fetchLeaveDashboardData();
  }

  void changeSubTab(int index) => selectedSubTab.value = index;

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
  }

  Future<void> fetchMyAttendanceData() async {
    try {
      isLoading.value = true;
      isError.value = false;
      errorMessage.value = '';

      final response = await ApiService().get(
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

      final response = await ApiService().get(
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
    } finally {
      isLoading.value = false;
    }
  }
}
