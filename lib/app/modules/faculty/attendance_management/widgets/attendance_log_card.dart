// -----------------------------------------------------------------------------
// Widgets (lib/app/modules/faculty/attendance_management/widgets/attendance_log_card.dart) - NEW
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../models/faculty_attendance_log_model.dart';

class AttendanceLogCard extends StatelessWidget {
  final AttendanceLogEntry logEntry;

  const AttendanceLogCard({super.key, required this.logEntry});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusTextColor;
    IconData statusIcon;

    switch (logEntry.status.toLowerCase()) {
      case 'present':
        statusColor = AppColors.statusPresentGreen;
        statusTextColor = AppColors.statusPresentText;
        statusIcon = Icons.check_circle_outline;
        break;
      case 'absent':
        statusColor = AppColors.statusAbsentRed;
        statusTextColor = AppColors.statusAbsentText;
        statusIcon = Icons.cancel_outlined;
        break;
      case 'late':
        statusColor = AppColors.warningYellow.withOpacity(0.2); // Lighter yellow
        statusTextColor = AppColors.warningYellow;
        statusIcon = Icons.access_time_outlined;
        break;
      case 'leave':
        statusColor = AppColors.statusLeaveGrey;
        statusTextColor = AppColors.statusLeaveText;
        statusIcon = Icons.description_outlined;
        break;
      default:
        statusColor = Colors.grey[100]!;
        statusTextColor = Colors.grey[600]!;
        statusIcon = Icons.info_outline;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd MMM').format(logEntry.date),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              Text(
                DateFormat('EEEE').format(logEntry.date),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textGray,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          // Status and Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(statusIcon, size: 16, color: statusTextColor),
                    const SizedBox(width: 5),
                    Text(
                      logEntry.status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                if (logEntry.inTime != null || logEntry.outTime != null)
                  Text(
                    'In: ${logEntry.inTime != null ? DateFormat('hh:mm a').format(logEntry.inTime!) : '--:--'} Out: ${logEntry.outTime != null ? DateFormat('hh:mm a').format(logEntry.outTime!) : '--:--'}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textBlack),
                  ),
                if (logEntry.note != null && logEntry.note!.isNotEmpty)
                  Text(
                    'Note: ${logEntry.note}',
                    style: const TextStyle(fontSize: 12, color: AppColors.textGray),
                  ),
              ],
            ),
          ),
          // Optional: Download button for log entry
          if (logEntry.status.toLowerCase() == 'leave' && logEntry.note != null)
            IconButton(
              icon: const Icon(Icons.file_download, color: AppColors.primaryBlue),
              onPressed: () {
                Get.snackbar('Download', 'Downloading document for ${logEntry.date} leave.');
                // Implement actual download logic
              },
            ),
        ],
      ),
    );
  }
}