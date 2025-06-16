import 'package:flutter/material.dart';
import 'attendance_summary.dart';
import 'pending_assignments_summary.dart';
import 'fee_status_summary.dart';

import 'upcomming_exams_summary.dart';

class SummaryHorizontalSection extends StatelessWidget {
  const SummaryHorizontalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,

        children: const [
          AttendanceSummary(),
          SizedBox(width: 16),

          PendingAssignmentsSummary(),
          SizedBox(width: 16),

          UpcomingExamsSummary(),
          SizedBox(width: 16),

          FeeStatusSummary(),
        ],
      ),
    );
  }
}
