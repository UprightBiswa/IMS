// lib/app/modules/assignments/widgets/subject_assignment_card.dart
import 'package:flutter/material.dart';

import '../models/assignment_summary_model.dart'; // For .toPrecision(0) extension


class SubjectAssignmentCard extends StatelessWidget {
  final SubjectAssignmentBreakdown breakdown;

  const SubjectAssignmentCard({super.key, required this.breakdown});

  @override
  Widget build(BuildContext context) {
    final completionRatio = breakdown.total > 0 ? breakdown.completed / breakdown.total : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                breakdown.subject,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              Text(
                '${breakdown.percentage}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: breakdown.barColor, // Use color from model
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${breakdown.completed} / ${breakdown.total} Completed',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              Text(
                breakdown.status,
                style: TextStyle(
                  fontSize: 13,
                  color: breakdown.barColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: completionRatio,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(breakdown.barColor),
            ),
          ),
        ],
      ),
    );
  }
}