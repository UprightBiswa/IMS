import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/student_attendance_controller.dart';
import '../models/subjectwise_attendance_model.dart';

class Last17DaysAttendanceChart extends StatelessWidget {
  const Last17DaysAttendanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentAttendanceController controller = Get.find();

    return Obx(() {
      if (controller.dayWiseAttendanceList.isEmpty) {
        return const Center(
          child: Text("No daily attendance data available for chart."),
        );
      }

      // Get the last 17 days
      final List<DailyAttendanceData> last17Days =
          controller.dayWiseAttendanceList.length > 17
          ? controller.dayWiseAttendanceList.sublist(
              controller.dayWiseAttendanceList.length - 17,
            )
          : controller.dayWiseAttendanceList;

      // Determine date range for display
      String startDate = '';
      String endDate = '';
      if (last17Days.isNotEmpty) {
        startDate = DateFormat('MMM d').format(last17Days.first.date);
        endDate = DateFormat('MMM d').format(last17Days.last.date);
      }

      return Column(
        children: [
          AttendanceCard(
            attendanceData: last17Days,
            startDate: startDate,
            endDate: endDate,
          ),
          const SizedBox(height: 16),
          Center(
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: AppColors.secondaryTextGray.withValues(alpha: .20),
                  width: 1,
                ),
              ),
              icon: const Icon(
                Icons.download,
                size: 16,
                color: AppColors.secondaryTextGray,
              ),
              onPressed: () {},
              label: const Text(
                "Download Attendance Report",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryTextGray,
                ),
              ), // style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      );
    });
  }
}

class AttendanceDay {
  final String day;
  final bool present;

  AttendanceDay({required this.day, required this.present});
}

class AttendanceCard extends StatelessWidget {
  final List<DailyAttendanceData> attendanceData;
  final String startDate;
  final String endDate;

  const AttendanceCard({
    super.key,
    required this.attendanceData,
    required this.startDate,
    required this.endDate,
  });
  Color getBarColor(double percentage) {
    if (percentage >= 75) {
      return Colors.teal; // Green-like color for good attendance
    } else if (percentage > 0) {
      return Colors.orange; // Orange for some attendance but below threshold
    } else {
      return Colors.red[300]!; // Red for 0% attendance
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.black.withValues(alpha: .03)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Last 17 Days Attendance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          // Bar Chart Section
          // Bar Chart Section
          SizedBox(
            height: 100, // Fixed height for the chart area
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment:
                  CrossAxisAlignment.end, // Align bars at the bottom
              children: List.generate(attendanceData.length, (index) {
                final data = attendanceData[index];
                final barColor = getBarColor(data.percentage);
                final barHeight =
                    data.percentage *
                    0.5; // Scale percentage to height (max 50)
                final dayLabel = DateFormat(
                  'd',
                ).format(data.date); // Just the day number

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      // Allow bars to take available height
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 8, // Width of each bar
                          height: barHeight.clamp(
                            5.0,
                            50.0,
                          ), // Ensure min height for visibility
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ), // Space between bar and day number
                    Text(
                      dayLabel,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          // Date Range Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startDate,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                endDate,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
