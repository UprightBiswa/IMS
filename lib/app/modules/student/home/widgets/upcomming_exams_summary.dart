import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import 'dashboard_summary_card.dart';

class UpcomingExamsSummary extends StatelessWidget {
  const UpcomingExamsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSummaryCard(
      title: "Upcoming Exams",
      icon: Icons.timer_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "2",
            style: TextStyle(
              fontSize: 24,
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "In next 7 days",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE9F2FC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Data Structures",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  "May 15, 2025",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: () {
                // Navigate to exam schedule
              },
              child: const Text(
                "View Exam Schedule",
                style: TextStyle(
                  color: AppColors.primaryBlue,

                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
