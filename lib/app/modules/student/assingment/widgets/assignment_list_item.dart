// lib/modules/assignments/widgets/assignment_list_item.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../theme/app_colors.dart';
import '../models/assignment_model.dart';

class AssignmentListItem extends StatelessWidget {
  final Assignment assignment;

  const AssignmentListItem({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;
    bool isOverdue = assignment.status == AssignmentStatus.overdue;
    bool isSubmitted = assignment.status == AssignmentStatus.submitted;

    if (isOverdue) {
      statusColor = AppColors.error;
      statusText = 'OVERDUE';
    } else if (isSubmitted) {
      statusColor = AppColors.success;
      statusText = 'SUBMITTED';
    } else {
      final daysRemaining = assignment.dueDate
          .difference(DateTime.now())
          .inDays;
      if (daysRemaining <= 0) {
        // If due date is today or passed (but not yet marked overdue)
        statusColor = AppColors.warning;
        statusText = 'Due Today';
      } else if (daysRemaining <= 7) {
        statusColor = AppColors.info;
        statusText = 'Due in $daysRemaining days';
      } else {
        statusColor = Colors.grey;
        statusText = 'Upcoming';
      }
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              assignment.subject,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.greyText,
              ), // Using AppColors
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: AppColors.greyText),
                const SizedBox(width: 4),
                Text(
                  'Due: ${assignment.dueDate.toLocal().toString().split(' ')[0]}', // Format date
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.greyText,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.person, size: 16, color: AppColors.greyText),
                const SizedBox(width: 4),
                Text(
                  assignment.professor,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.greyText,
                  ),
                ),
              ],
            ),
            if (assignment.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                assignment.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textBlack,
                ), // Using AppColors
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (assignment.attachedFiles.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Attached: ${assignment.attachedFiles.join(', ')}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.accentBlue,
                ), // Using AppColors
              ),
            ],
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: OutlinedButton(
                onPressed: () {
                  Get.snackbar('Action', 'Tapped on ${assignment.title}');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  side: BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isSubmitted ? 'View Details' : 'Open Assignment',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
