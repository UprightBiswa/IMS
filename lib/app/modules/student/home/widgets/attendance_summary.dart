import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dashboard_summary_card.dart';

class AttendanceSummary extends StatelessWidget {
  const AttendanceSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSummaryCard(
      title: "Attendance Summary",
      icon: Icons.calendar_month_outlined,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SummaryPersentage(),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              AttendanceStat(label: "Today", value: "92%", color: Colors.blue),
              AttendanceStat(label: "Week", value: "89%", color: Colors.green),
              AttendanceStat(
                label: "Month",
                value: "85%",
                color: Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              // Navigate to full attendance view
            },
            child: const Text(
              "View Full Attendance",
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AttendanceStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const AttendanceStat({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

//
class SummaryPersentage extends StatelessWidget {
  const SummaryPersentage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: 0.82, // 82%
            strokeWidth: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.primaryBlue,
            ),
          ),
        ),
        Column(
          children: const [
            Text(
              "82%",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textBlack,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Good",
                  style: TextStyle(color: AppColors.primaryBlue, fontSize: 12),
                ),
                SizedBox(width: 4),
                Icon(Icons.check_circle, color: Colors.green, size: 14),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
