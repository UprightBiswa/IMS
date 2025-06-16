import 'package:flutter/material.dart';
import '../widgets/attendance_summy_card.dart';
import '../widgets/last_17_days_attendance_chart.dart';
import '../widgets/recommendad_action_card.dart';
import '../widgets/subject_wise_attendance_card_list.dart';

class AttendanceOverviewTab extends StatelessWidget {
  const AttendanceOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        AttendanceSummaryCard(),
        SizedBox(height: 16),
        SubjectWiseAttendanceCardList(),
        SizedBox(height: 16),
        RecommendedActionsCard(),
        SizedBox(height: 16),
        Last17DaysAttendanceChart(),
      ],
    );
  }
}
