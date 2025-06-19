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

  String getFormattedDateRange(DateTime startDate, DateTime endDate) {
    final sameDay = startDate.isAtSameMomentAs(endDate);
    final sameMonth = startDate.month == endDate.month;
    final sameYear = startDate.year == endDate.year;

    if (sameDay) {
      // Format: Mar 22, 2025
      return DateFormat('MMM d, yyyy').format(startDate);
    } else if (sameMonth && sameYear) {
      // Format: Apr 10-12, 2025
      final startDay = DateFormat('d').format(startDate);
      final endDay = DateFormat('d').format(endDate);
      return '${DateFormat('MMM').format(startDate)} $startDay-$endDay, ${startDate.year}';
    } else {
      // Format: Apr 30, 2025 to May 2, 2025 (different month or year)
      final start = DateFormat('MMM d, yyyy').format(startDate);
      final end = DateFormat('MMM d, yyyy').format(endDate);
      return '$start to $end';
    }
  }

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
                  getFormattedDateRange(request.startDate, request.endDate),
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
