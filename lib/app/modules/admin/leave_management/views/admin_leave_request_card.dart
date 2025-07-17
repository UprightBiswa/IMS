// -----------------------------------------------------------------------------
// Views (lib/app/modules/admin/leave_management/views/admin_leave_request_card.dart)
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../controllers/admin_leave_controller.dart';
import '../models/admin_leave_application_model.dart';

class AdminLeaveRequestCard extends StatelessWidget {
  final AdminLeaveApplicationModel leave;
  final AdminLeaveController controller; // Pass controller for actions

  const AdminLeaveRequestCard({
    super.key,
    required this.leave,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusTextColor;
    IconData statusIcon;

    String displayStatus = leave.finalStatus ?? leave.status;

    if (displayStatus == 'approved' || displayStatus == 'faculty_approved') {
      statusColor = Colors.green[50]!;
      statusIcon = Icons.check_circle;
      statusTextColor = Colors.green[700]!;
      displayStatus = 'Approved';
    } else if (displayStatus == 'rejected' || displayStatus.contains('rejected')) {
      statusColor = Colors.red[50]!;
      statusIcon = Icons.cancel;
      statusTextColor = Colors.red[700]!;
      displayStatus = 'Rejected';
    } else if (displayStatus == 'pending' || displayStatus == 'admin_approved') {
      statusColor = Colors.orange[50]!;
      statusIcon = Icons.access_time;
      statusTextColor = Colors.orange[700]!;
      displayStatus = displayStatus.capitalizeFirst!;
    } else {
      statusColor = Colors.grey[50]!;
      statusIcon = Icons.info;
      statusTextColor = Colors.grey[700]!;
    }

    final String dateRange =
        '${DateFormat('MMM d, yyyy').format(leave.startDate)} - ${DateFormat('MMM d, yyyy').format(leave.endDate)}';
    final String submittedDate = DateFormat('MMM d, yyyy').format(leave.createdAt);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leave.userName ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  Text(
                    '${leave.userRole ?? 'N/A'} - ${leave.userDepartment ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 14, color: statusTextColor),
                    const SizedBox(width: 6),
                    Text(
                      displayStatus,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 20, thickness: 0.5),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                dateRange,
                style: const TextStyle(fontSize: 13, color: AppColors.textBlack),
              ),
              const SizedBox(width: 20),
              Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                '${leave.totalDays} days',
                style: const TextStyle(fontSize: 13, color: AppColors.textBlack),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                'Type: ${leave.leaveType.capitalizeFirst!}',
                style: const TextStyle(fontSize: 13, color: AppColors.textBlack),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Reason: ${leave.reason}',
            style: const TextStyle(fontSize: 13, color: AppColors.textBlack),
          ),
          const SizedBox(height: 8),
          Text(
            'Submitted on: $submittedDate',
            style: const TextStyle(fontSize: 11, color: AppColors.textGray),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leave.status == 'pending') // Show action buttons only for pending
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => controller.reviewLeaveApplication(leave.id, 'approve'),
                        icon: const Icon(Icons.check, size: 18),
                        label: const Text('Approve'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () => controller.reviewLeaveApplication(leave.id, 'reject'),
                        icon: const Icon(Icons.close, size: 18),
                        label: const Text('Reject'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.dangerRed,
                          side: const BorderSide(color: AppColors.dangerRed),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle download logic
                    Get.snackbar('Download', 'Downloading document for ${leave.id}');
                  },
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Documents'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkBlue,
                    side: const BorderSide(color: AppColors.darkBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
