import 'package:attendance_demo/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Last17DaysAttendanceChart extends StatelessWidget {
  const Last17DaysAttendanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AttendanceCard(),
        const SizedBox(height: 16),
        Center(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
  }
}

class AttendanceDay {
  final String day;
  final bool present;

  AttendanceDay({required this.day, required this.present});
}

class AttendanceCard extends StatelessWidget {
  AttendanceCard({super.key});

  // Define attendance data.
  // 0: Absent (Red)
  // 1: Present (Green)
  // 2: Late/Half-day (Orange)
  final List<int> attendanceData = [
    1, 1, 1, 1, 0, // Days 1-5
    -1, -1, // Days 6-7 (No data/empty in the image, represented as -1)
    1, 2, 1, 1, 1, // Days 8-12
    -1, -1, // Days 13-14
    0, 1, 1, // Days 15-17
  ];

  Color getBarColor(int status) {
    switch (status) {
      case 1:
        return Colors.teal; // Green-like color from the image
      case 0:
        return Colors.red[300]!; // Red-like color from the image
      case 2:
        return Colors.orange; // Orange color from the image
      default:
        return Colors.transparent; // For empty days
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment:
                CrossAxisAlignment.end, // Align bars at the bottom
            children: List.generate(17, (index) {
              final day = index + 1;
              final attendanceStatus = attendanceData.length > index
                  ? attendanceData[index]
                  : -1;
              final barColor = getBarColor(attendanceStatus);
              final barHeight = attendanceStatus != -1
                  ? 50.0
                  : 0.0; // Height for actual bars

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8, // Width of each bar
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(
                        2,
                      ), // Slightly rounded tops for bars
                    ),
                  ),
                  const SizedBox(height: 4), // Space between bar and day number
                  Text(
                    '$day',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 20),
          // Date Range Section
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('May 1', style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text(
                'May 17',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
