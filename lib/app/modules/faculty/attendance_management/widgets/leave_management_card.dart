import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      request.leaveType,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkText,
                      ),
                    ),
                  ],
                ),
                Text(
                 request.leaveDates,
                  style: TextStyle(fontSize: 12, color: AppColors.greyText),
                ),
                Text(
                  '${request.days} day(s)',
                  style: TextStyle(fontSize: 10, color: AppColors.greyText),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: request.statusColor.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              request.statusString,
              style: TextStyle(fontSize: 11, color: request.statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
