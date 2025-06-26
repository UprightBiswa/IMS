import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
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
      QuickLinkModel(
        title: "Attendance",
        icon: Icons.check_circle_outline,
        route: Routes.ATTENDANCE,
      ),
      QuickLinkModel(
        title: "Timetable",
        icon: Icons.schedule,
        route: Routes.TIMETABLE,
      ),
      QuickLinkModel(
        title: "Assignments",
        icon: Icons.assignment_outlined,
        route: Routes.ASSIGNMENTS,
      ),
      QuickLinkModel(
        title: "Messages",
        icon: Icons.message_outlined,
        route: Routes.MESSAGES,
      ),
      QuickLinkModel(
        title: "Syllabus",
        icon: Icons.menu_book_outlined,
        route: Routes.SYLLABUS,
      ),
      QuickLinkModel(
        title: "Exams",
        icon: Icons.edit_calendar_outlined,
        route: Routes.EXAMS,
      ),
      QuickLinkModel(
        title: "Library",
        icon: Icons.local_library_outlined,
        route: Routes.LIBRARY,
      ),
      QuickLinkModel(
        title: "Fees",
        icon: Icons.attach_money_outlined,
        route: Routes.FEES,
      ),
      QuickLinkModel(
        title: "Grades",
        icon: Icons.grade_outlined,
        route: Routes.GRADES,
      ),
    ];
  }
}
