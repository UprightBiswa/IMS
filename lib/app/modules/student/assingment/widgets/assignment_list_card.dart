// lib/app/modules/assignments/widgets/assignment_list_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../models/assignment_model.dart';

class AssignmentListCard extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback? onTap;

  const AssignmentListCard({
    super.key,
    required this.assignment,
    this.onTap,
  });

  Color _getStatusColor(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.submitted:
      case AssignmentStatus.graded:
        return Colors.green;
      case AssignmentStatus.dueSoon:
        return Colors.orange;
      case AssignmentStatus.overdue:
        return Colors.red;
      case AssignmentStatus.pending:
      return Colors.blueGrey;
    }
  }

  IconData _getStatusIcon(AssignmentStatus status) {
    switch (status) {
      case AssignmentStatus.submitted:
      case AssignmentStatus.graded:
        return Icons.check_circle_outline;
      case AssignmentStatus.dueSoon:
        return Icons.timer_outlined;
      case AssignmentStatus.overdue:
        return Icons.error_outline;
      case AssignmentStatus.pending:
      return Icons.pending_actions_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(assignment.status);
    final statusIcon = _getStatusIcon(assignment.status);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    assignment.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(statusIcon, size: 16, color: statusColor),
                      const SizedBox(width: 4),
                      Text(
                        assignment.status.name.capitalizeFirst!,
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${assignment.subject} • ${assignment.professor}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textGray,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textGray),
                const SizedBox(width: 4),
                Text(
                  'Due: ${DateFormat('MMM dd, yyyy').format(assignment.dueDate)}',
                  style: const TextStyle(fontSize: 13, color: AppColors.textGray),
                ),
                const SizedBox(width: 12),
                Icon(Icons.access_time, size: 16, color: AppColors.textGray),
                const SizedBox(width: 4),
                Text(
                  DateFormat('hh:mm a').format(assignment.dueDate),
                  style: const TextStyle(fontSize: 13, color: AppColors.textGray),
                ),
              ],
            ),
            if (assignment.grade != null && assignment.status == AssignmentStatus.graded) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.grade, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    'Grade: ${assignment.grade}%',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}