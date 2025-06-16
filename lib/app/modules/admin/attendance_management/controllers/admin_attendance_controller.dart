import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/summary_card_model.dart';

class AttendanceDashboardController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Students, 1: Faculty, 2: Staff

  void changeTab(int index) {
    selectedTab.value = index;
  }

  final List<SummaryCardModel> studentSummaryCards = [
    SummaryCardModel(
      title: "Total Students",
      value: "1,245",
      subtitle: "Across 10 classes",
      icon: Icons.people_alt_outlined,
      backgroundColor: const Color(0xFFF6FAFE),
    ),
    SummaryCardModel(
      title: "Today's Attendance",
      value: "92%",
      subtitle: "1,145 present",
      icon: Icons.calendar_today_outlined,
      backgroundColor: const Color(0xFFF7FDF9),
    ),
    SummaryCardModel(
      title: "Absent Students",
      value: "100",
      subtitle: "8% of total",
      icon: Icons.person_off_outlined,
      backgroundColor: const Color(0xFFFEF8F8),
    ),
    SummaryCardModel(
      title: "Weekly Attendance",
      value: "95 %",
      subtitle: "",
      icon: Icons.favorite_outline,
      backgroundColor: const Color(0xFFF6F8FE),
      progressValue: 0.95,
    ),
  ];

  final List<SummaryCardModel> facultySummaryCards = [
    SummaryCardModel(
      title: "Total Faculty",
      value: "48",
      subtitle: "Across 6 departments",
      icon: Icons.business_center_outlined,
      backgroundColor: const Color(0xFFF6FAFE),
    ),
    SummaryCardModel(
      title: "Classes Today",
      value: "42",
      subtitle: "Above 95%",
      icon: Icons.school_outlined,
      backgroundColor: const Color(0xFFF7FDF9),
    ),
    SummaryCardModel(
      title: "Attendance Marked",
      value: "37",
      subtitle: "5 classes pending",
      icon: Icons.check_circle_outline,
      backgroundColor: const Color(0xFFF7FDF9),
    ),
    SummaryCardModel(
      title: "Daily Compliance",
      value: "88%",
      subtitle: "Today's Progress",
      icon: Icons.calendar_view_day_outlined,
      backgroundColor: const Color(0xFFF6F8FE),
      progressValue: 0.88,
    ),
  ];

  final List<SummaryCardModel> staffSummaryCards = [
    SummaryCardModel(
      title: "Total Staff",
      value: "32",
      subtitle: "Across 6 departments",
      icon: Icons.people_outline,
      backgroundColor: const Color(0xFFF6FAFE),
    ),
    SummaryCardModel(
      title: "Present Today",
      value: "28",
      subtitle: "On time:28",
      icon: Icons.calendar_today_outlined,
      backgroundColor: const Color(0xFFF7FDF9),
    ),
    SummaryCardModel(
      title: "Absent Today",
      value: "4",
      subtitle: "12.5% of total",
      icon: Icons.person_off_outlined,
      backgroundColor: const Color(0xFFFEF8F8),
    ),
    SummaryCardModel(
      title: "Attendance Rate",
      value: "88%",
      subtitle: "Today's Progress",
      icon: Icons.trending_up_outlined,
      backgroundColor: const Color(0xFFF6F8FE),
      progressValue: 0.88,
    ),
  ];
}
