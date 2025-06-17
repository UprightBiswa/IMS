// lib/app/modules/faculty/attendance_management/views/widgets/leave_request_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../models/leave_request_model.dart';

class LeaveRequestCard extends StatelessWidget {
  final LeaveRequest request;
  final bool showDownloadButton;

  const LeaveRequestCard({
    super.key,
    required this.request,
    this.showDownloadButton = true,
  });

  @override
  Widget build(BuildContext context) {
    String dateRange;
    if (request.startDate == request.endDate) {
      dateRange = DateFormat('yyyy-MM-dd').format(request.startDate);
    } else {
      dateRange =
          '${DateFormat('yyyy-MM-dd').format(request.startDate)} to ${DateFormat('yyyy-MM-dd').format(request.endDate)}';
    }

    return Card(
      elevation: 0.5, // Slightly less elevation for list items
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateRange,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkText,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: request.statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      if (request.status == LeaveStatus.Approved)
                        Icon(Icons.check_circle_outline,
                            color: request.statusColor, size: 16),
                      if (request.status == LeaveStatus.Rejected)
                        Icon(Icons.cancel_outlined,
                            color: request.statusColor, size: 16),
                      if (request.status == LeaveStatus.Pending)
                        Icon(Icons.hourglass_empty_outlined,
                            color: request.statusColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        request.statusString,
                        style: TextStyle(
                          fontSize: 11,
                          color: request.statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Reason: ${request.reason}',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.greyText,
              ),
            ),
            Text(
              'Submitted on ${DateFormat('yyyy-MM-dd').format(request.submittedDate)}',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.greyText,
              ),
            ),
            if (showDownloadButton) // Only show if needed, e.g., for Approved/Rejected
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    print('Download Letter for ${request.id}');
                    // Implement download logic
                  },
                  icon: const Icon(Icons.download_rounded, size: 20),
                  label: const Text('Download Letter'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                  ),
                ),
              ),
            if (request.status == LeaveStatus.Pending) // Add an option to cancel pending requests
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    print('Cancel Request for ${request.id}');
                    // Implement cancel logic in controller
                  },
                  icon: const Icon(Icons.close, size: 20, color: AppColors.primaryRed),
                  label: const Text('Cancel Request', style: TextStyle(color: AppColors.primaryRed)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}