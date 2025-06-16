import 'package:get/get.dart';
import '../model/quick_link_model.dart';
import 'package:flutter/material.dart';

class QuickLinkController extends GetxController {
  var quickLinks = <QuickLinkModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadQuickLinks();
  }

  void loadQuickLinks() {
    quickLinks.value = [
      QuickLinkModel(title: "Attendance", icon: Icons.check_circle_outline, route: '/attendance'),
      QuickLinkModel(title: "Timetable", icon: Icons.schedule, route: '/timetable'),
      QuickLinkModel(title: "Assignments", icon: Icons.assignment_outlined, route: '/assignments'),
      QuickLinkModel(title: "Messages", icon: Icons.message_outlined, route: '/messages'),
      QuickLinkModel(title: "Syllabus", icon: Icons.menu_book_outlined, route: '/syllabus'),
      QuickLinkModel(title: "Exams", icon: Icons.edit_calendar_outlined, route: '/exams'),
      QuickLinkModel(title: "Library", icon: Icons.local_library_outlined, route: '/library'),
      QuickLinkModel(title: "Fees", icon: Icons.attach_money_outlined, route: '/fees'),
      QuickLinkModel(title: "Grades", icon: Icons.grade_outlined, route: '/grades'),
    ];
  }
}
