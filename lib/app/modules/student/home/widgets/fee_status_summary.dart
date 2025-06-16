import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import 'dashboard_summary_card.dart';

class FeeStatusSummary extends StatelessWidget {
  const FeeStatusSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSummaryCard(
      title: "Fee Status",
      icon: Icons.credit_card_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "₹15,000",
            style: TextStyle(
              fontSize: 24,
              color: AppColors.primaryBlue,

              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Due by May 31, 2025",
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Semester Fee",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              Text(
                "60% Paid",
                style: TextStyle(fontSize: 12, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: () {
                // Navigate to fee details
              },
              child: const Text(
                "View Fee Details",
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
