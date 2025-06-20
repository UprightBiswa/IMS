import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/api_endpoints.dart';
import '../../../../services/api_service.dart';
import '../models/faculty_overview_model.dart';
import '../models/staff_over_view_model.dart';
import '../models/student_class_snap_shot_model.dart';
import '../models/summary_card_model.dart';

class AttendanceDashboardController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Students, 1: Faculty, 2: Staff

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<StudentClassSnapshotModel> studentClassSnapshot =
      <StudentClassSnapshotModel>[].obs;

  final RxList<SummaryCardModel> studentSummaryCards = <SummaryCardModel>[].obs;

  final RxList<SummaryCardModel> facultySummaryCards = <SummaryCardModel>[].obs;
  final RxList<SummaryCardModel> staffSummaryCards = <SummaryCardModel>[].obs;

  final RxList<FacultyOverviewModel> facultyData = <FacultyOverviewModel>[].obs;
  final RxList<StaffOverviewModel> staffData = <StaffOverviewModel>[].obs;
  void changeTab(int index) {
    selectedTab.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchStudentOverview();
    fetchFacultyOverview();
    fetchStaffOverview();
  }

  Future<void> fetchStudentOverview() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await ApiService().get(
        ApiEndpoints.ADMIN_DASHBOARD_STUDENT_MAPP,
      );
      final data = response.data['data']['student_data'];

      // Parse class snapshot list
      final List snapshotList = data['class_attendance_snapshot'];
      studentClassSnapshot.value = snapshotList
          .map((e) => StudentClassSnapshotModel.fromJson(e))
          .toList();

      // Summary cards
      final summary = data['summary'];
      studentSummaryCards.value = [
        SummaryCardModel(
          title: "Total Students",
          value: summary['total_students'].toString(),
          subtitle: "Across ${summary['total_classes']} classes",
          icon: Icons.people_alt_outlined,
          backgroundColor: const Color(0xFFF6FAFE),
        ),
        SummaryCardModel(
          title: "Today's Attendance",
          value: "${summary['total_attendance_today_percentage']}%",
          subtitle: "${summary['total_students_present_today']} present",
          icon: Icons.calendar_today_outlined,
          backgroundColor: const Color(0xFFF7FDF9),
        ),
        SummaryCardModel(
          title: "Absent Students",
          value: summary['absent_students_today'].toString(),
          subtitle: "${summary['absent_students_today_percentage']}% of total",
          icon: Icons.person_off_outlined,
          backgroundColor: const Color(0xFFFEF8F8),
        ),
        SummaryCardModel(
          title: "Weekly Attendance",
          value: "${summary['weekly_attendance_percentage']}%",
          subtitle: "",
          icon: Icons.favorite_outline,
          backgroundColor: const Color(0xFFF6F8FE),
          progressValue: summary['weekly_attendance_percentage'] / 100,
        ),
      ];
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFacultyOverview() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await ApiService().get(
        ApiEndpoints.ADMIN_DASHBOARD_FACULTY_MAPP,
      );
      final data = response.data['data']['faculty_data'];

      // Attendance data
      final List overviewList = data['faculty_attendance_overview'];
      facultyData.value = overviewList
          .map((e) => FacultyOverviewModel.fromJson(e))
          .toList();

      // Summary
      final summary = data['summary'];
      facultySummaryCards.value = [
        SummaryCardModel(
          title: "Total Faculty",
          value: summary['total_faculty'].toString(),
          subtitle: "Across 6 departments",
          icon: Icons.business_center_outlined,
          backgroundColor: const Color(0xFFF6FAFE),
        ),
        SummaryCardModel(
          title: "Classes Today",
          value: summary['classes_today'].toString(),
          subtitle: "Above 95%",
          icon: Icons.school_outlined,
          backgroundColor: const Color(0xFFF7FDF9),
        ),
        SummaryCardModel(
          title: "Attendance Marked",
          value: summary['attendance_marked'].toString(),
          subtitle:
              "${summary['classes_today'] - summary['attendance_marked']} classes pending",
          icon: Icons.check_circle_outline,
          backgroundColor: const Color(0xFFF7FDF9),
        ),
        SummaryCardModel(
          title: "Daily Compliance",
          value: "${summary['todays_progress_perntage']}%",
          subtitle: "Today's Progress",
          icon: Icons.calendar_view_day_outlined,
          backgroundColor: const Color(0xFFF6F8FE),
          progressValue: summary['todays_progress_perntage'] / 100,
        ),
      ];
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStaffOverview() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await ApiService().get(
        ApiEndpoints.ADMIN_DASHBOARD_STAFF_MAPP,
      );
      final data = response.data['data']['staff_data'];

      final List overviewList = data['staff_attendance_overview'];
      staffData.value = overviewList
          .map((e) => StaffOverviewModel.fromJson(e))
          .toList();

      final summary = data['summary'];
      staffSummaryCards.value = [
        SummaryCardModel(
          title: "Total Staff",
          value: summary['total_staff'].toString(),
          subtitle: "Across 6 departments",
          icon: Icons.people_outline,
          backgroundColor: const Color(0xFFF6FAFE),
        ),
        SummaryCardModel(
          title: "Present Today",
          value: summary['present_today'].toString(),
          subtitle: "On time: ${summary['present_today']}",
          icon: Icons.calendar_today_outlined,
          backgroundColor: const Color(0xFFF7FDF9),
        ),
        SummaryCardModel(
          title: "Absent Today",
          value: summary['absent_today'].toString(),
          subtitle:
              "${(summary['absent_today'] / summary['total_staff'] * 100).toStringAsFixed(1)}% of total",
          icon: Icons.person_off_outlined,
          backgroundColor: const Color(0xFFFEF8F8),
        ),
        SummaryCardModel(
          title: "Attendance Rate",
          value: "${summary['todays_progress_perntage']}%",
          subtitle: "Today's Progress",
          icon: Icons.trending_up_outlined,
          backgroundColor: const Color(0xFFF6F8FE),
          progressValue: summary['todays_progress_perntage'] / 100,
        ),
      ];
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // final List<SummaryCardModel> studentSummaryCards = [
  //   SummaryCardModel(
  //     title: "Total Students",
  //     value: "1,245",
  //     subtitle: "Across 10 classes",
  //     icon: Icons.people_alt_outlined,
  //     backgroundColor: const Color(0xFFF6FAFE),
  //   ),
  //   SummaryCardModel(
  //     title: "Today's Attendance",
  //     value: "92%",
  //     subtitle: "1,145 present",
  //     icon: Icons.calendar_today_outlined,
  //     backgroundColor: const Color(0xFFF7FDF9),
  //   ),
  //   SummaryCardModel(
  //     title: "Absent Students",
  //     value: "100",
  //     subtitle: "8% of total",
  //     icon: Icons.person_off_outlined,
  //     backgroundColor: const Color(0xFFFEF8F8),
  //   ),
  //   SummaryCardModel(
  //     title: "Weekly Attendance",
  //     value: "95 %",
  //     subtitle: "",
  //     icon: Icons.favorite_outline,
  //     backgroundColor: const Color(0xFFF6F8FE),
  //     progressValue: 0.95,
  //   ),
  // ];

  // final List<SummaryCardModel> facultySummaryCards = [
  //   SummaryCardModel(
  //     title: "Total Faculty",
  //     value: "48",
  //     subtitle: "Across 6 departments",
  //     icon: Icons.business_center_outlined,
  //     backgroundColor: const Color(0xFFF6FAFE),
  //   ),
  //   SummaryCardModel(
  //     title: "Classes Today",
  //     value: "42",
  //     subtitle: "Above 95%",
  //     icon: Icons.school_outlined,
  //     backgroundColor: const Color(0xFFF7FDF9),
  //   ),
  //   SummaryCardModel(
  //     title: "Attendance Marked",
  //     value: "37",
  //     subtitle: "5 classes pending",
  //     icon: Icons.check_circle_outline,
  //     backgroundColor: const Color(0xFFF7FDF9),
  //   ),
  //   SummaryCardModel(
  //     title: "Daily Compliance",
  //     value: "88%",
  //     subtitle: "Today's Progress",
  //     icon: Icons.calendar_view_day_outlined,
  //     backgroundColor: const Color(0xFFF6F8FE),
  //     progressValue: 0.88,
  //   ),
  // ];

  // final List<SummaryCardModel> staffSummaryCards = [
  //   SummaryCardModel(
  //     title: "Total Staff",
  //     value: "32",
  //     subtitle: "Across 6 departments",
  //     icon: Icons.people_outline,
  //     backgroundColor: const Color(0xFFF6FAFE),
  //   ),
  //   SummaryCardModel(
  //     title: "Present Today",
  //     value: "28",
  //     subtitle: "On time:28",
  //     icon: Icons.calendar_today_outlined,
  //     backgroundColor: const Color(0xFFF7FDF9),
  //   ),
  //   SummaryCardModel(
  //     title: "Absent Today",
  //     value: "4",
  //     subtitle: "12.5% of total",
  //     icon: Icons.person_off_outlined,
  //     backgroundColor: const Color(0xFFFEF8F8),
  //   ),
  //   SummaryCardModel(
  //     title: "Attendance Rate",
  //     value: "88%",
  //     subtitle: "Today's Progress",
  //     icon: Icons.trending_up_outlined,
  //     backgroundColor: const Color(0xFFF6F8FE),
  //     progressValue: 0.88,
  //   ),
  // ];
}
