import 'package:get/get.dart';
import '../models/faculty_attendance_model.dart'; // Import the new models

class FacultyMyAttendanceController extends GetxController {
  final RxInt selectedSubTab = 0.obs; // 0: Overview, 1: Leave

  final Rx<MonthlyAttendanceSummary> monthlySummary =
      MonthlyAttendanceSummary.dummy().obs;

  final RxList<CalendarDayStatus> calendarDays = <CalendarDayStatus>[].obs;

  final RxList<RecentActivity> recentActivities = <RecentActivity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generateDummyCalendarData();
    recentActivities.value = RecentActivity.dummyList();
  }

  void changeSubTab(int index) {
    selectedSubTab.value = index;
  }

  void _generateDummyCalendarData() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      final date = DateTime(now.year, now.month, i);
      int status = 0; // Default: None

      if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
        status = 0; // Weekend, no status
      } else if (i % 5 == 0) { // Every 5th day is late
        status = 3; // Late
      } else if (i % 7 == 0) { // Every 7th day is absent
        status = 2; // Absent
      } else if (i % 9 == 0) { // Every 9th day is leave
        status = 4; // Leave
      } else {
        status = 1; // Present
      }

      if (date.day == 5 || date.day == 16) {
        status = 2; // Absent (Red)
      } else if (date.day == 9) {
        status = 3; // Late (Yellow)
      } else if (date.day == 21) { // Selected day in image
        status = 1; // Present
      } else if (date.day == 10 || date.day == 12 || date.day == 14) { // Leave in image
         status = 4; // Leave
      }

      calendarDays.add(CalendarDayStatus(date: date, status: status));
    }
  }
}