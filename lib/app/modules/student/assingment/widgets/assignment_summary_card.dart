// lib/app/modules/assignments/widgets/assignment_summary_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/widgets/dashboard_summary_card.dart';
import '../models/assignment_summary_model.dart'; // For .toPrecision(0) extension



class AssignmentSummaryCard extends StatelessWidget {
  final AssignmentSummaryModel summary;

  const AssignmentSummaryCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return DashboardSummaryCard(
      title: "Overall Assignment Progress",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Assignments',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    '${summary.totalAssignments}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Completed',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    '${summary.completedAssignments}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: summary.completionPercentage / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${summary.completionPercentage.toPrecision(0)}% Completed',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                '${summary.pendingAssignments} Pending',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}