import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import 'dashboard_summary_card.dart';

class PendingAssignmentsSummary extends StatelessWidget {
  const PendingAssignmentsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSummaryCard(
      title: "Pending Assignments",
      icon: Icons.assignment_outlined,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "2 due this week",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: const Text(
                "Due tomorrow",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.3,
                minHeight: 6,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),

            const SizedBox(height: 12),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Navigate to assignments page
                },
                child: const Text(
                  "View All Assignments",
                  style: TextStyle(
                    color: AppColors.primaryBlue,

                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
