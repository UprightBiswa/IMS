// import 'package:flutter/material.dart';

// import '../../home/widgets/attendance_summary.dart';
// import '../../home/widgets/dashboard_summary_card.dart';

// class AttendanceSummaryCard extends StatelessWidget {
//   const AttendanceSummaryCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DashboardSummaryCard(
//       title: "Attendance Summary",
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// User Info and Attendance Circle
//           Row(
//             children: [
//               // Name and Roll
//               const Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Isha Sharma',
//                     style: TextStyle(fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     'Roll No: Btech-123',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               // Attendance Percentage
//               SummaryPersentage(),
//             ],
//           ),

//           const SizedBox(height: 20),

//           ClassesAttendedRow(),

//           const SizedBox(height: 8),

//           /// Classes Missed Count
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [],
//           ),

//           const SizedBox(height: 12),

//           /// Attendance Chips
//           Row(
//             spacing: 8,
//             children: const [
//               AttendanceChip(
//                 label: '80%',
//                 subLabel: 'Today\n4/5 Classes',
//                 color: Color(0xFFe3f2fd),
//                 textColor: Colors.blue,
//               ),
//               AttendanceChip(
//                 label: '89%',
//                 subLabel: 'Week\n16/18 Classes',
//                 color: Color(0xFFe8f5e9),
//                 textColor: Colors.green,
//               ),
//               AttendanceChip(
//                 label: '85%',
//                 subLabel: 'Month\n68/80 Classes',
//                 color: Color(0xFFfff3e0),
//                 textColor: Colors.orange,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AttendanceChip extends StatelessWidget {
//   final String label;
//   final String subLabel;
//   final Color color;
//   final Color textColor;

//   const AttendanceChip({
//     super.key,
//     required this.label,
//     required this.subLabel,
//     required this.color,
//     required this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 100,

//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: textColor,
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               subLabel,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 12, color: textColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ClassesAttendedRow extends StatelessWidget {
//   const ClassesAttendedRow({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Top Row: Label + Count
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Classes Attended',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//               ),
//               Text('69', style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ),
//         const SizedBox(height: 10),

//         /// Progress Bar with Legend
//         SizedBox(
//           height: 20,
//           child: Stack(
//             alignment: Alignment.centerLeft,
//             children: [
//               // Full bar
//               Container(
//                 height: 8,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//               ),

//               // Present bar (Blue)
//               FractionallySizedBox(
//                 widthFactor: 0.8, // 80%
//                 child: Container(
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//               ),

//               // Late bar (Yellow) on top of blue
//               FractionallySizedBox(
//                 widthFactor: 0.89, // total 89%
//                 child: Container(
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: Colors.orange,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//               ),

//               // Leave bar (Red) on top of previous
//               FractionallySizedBox(
//                 widthFactor: 0.85, // total 85%
//                 child: Container(
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: Colors.redAccent,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//               ),

//               // Min. required marker (small vertical line)
//               Positioned(
//                 left: MediaQuery.of(context).size.width * 0.85,
//                 child: Container(height: 16, width: 2, color: Colors.black87),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 10),

//         /// Attendance Legend
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               AttendanceLegend(color: Colors.blue, label: 'Present'),
//               AttendanceLegend(color: Colors.orange, label: 'Late'),
//               AttendanceLegend(color: Colors.redAccent, label: 'Leave'),
//               AttendanceLegend(color: Colors.green, label: 'Min. Required'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class AttendanceLegend extends StatelessWidget {
//   final Color color;
//   final String label;

//   const AttendanceLegend({super.key, required this.color, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           height: 8,
//           width: 8,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//         ),
//         const SizedBox(width: 4),
//         Text(label, style: const TextStyle(fontSize: 12)),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../attendance/controllers/student_attendance_controller.dart';
import '../../home/widgets/attendance_summary.dart';
import '../../home/widgets/dashboard_summary_card.dart';

class AttendanceSummaryCard extends StatelessWidget {
  const AttendanceSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentAttendanceController controller = Get.find();
    return Obx(() {
      if (controller.attendanceSummary.value == null) {
        return const Center(
          child: CircularProgressIndicator(),
        ); // Or a placeholder
      }
      final summary = controller.attendanceSummary.value!;
      return DashboardSummaryCard(
        title: "Attendance Summary",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// User Info and Attendance Circle
            Row(
              children: [
                // Name and Roll
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      summary.studentName,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Roll No: ${summary.rollNumber}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                // Attendance Percentage
                SummaryPersentage(value: summary.attendanceOverallPercentage),
              ],
            ),

            const SizedBox(height: 20),

            ClassesAttendedRow(
              totalSessionsEnrolled: summary.totalSessionsEnrolled,
            ),

            const SizedBox(height: 8),

            /// Classes Missed Count
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),

            const SizedBox(height: 12),

            /// Attendance Chips
            Row(
              spacing: 8,
              children: [
                AttendanceChip(
                  label:
                      '${summary.percentageTotalPresentToday.toStringAsFixed(0)}%',
                  subLabel:
                      'Today\n${summary.totalSessionsPresentToday}/${_getTodayTotalSessions(controller)} Classes',
                  color: const Color(0xFFe3f2fd),
                  textColor: Colors.blue,
                ),
                AttendanceChip(
                  label:
                      '${summary.percentageTotalPresentWeekly.toStringAsFixed(0)}%',
                  subLabel:
                      'Week\n${summary.totalSessionsPresentWeekly}/${summary.totalSessionsEnrolledWeekly} Classes',
                  color: const Color(0xFFe8f5e9),
                  textColor: Colors.green,
                ),
                AttendanceChip(
                  label:
                      '${summary.percentageTotalPresentMonthly.toStringAsFixed(0)}%',
                  subLabel:
                      'Month\n${summary.totalSessionsPresentMonthly}/${summary.totalSessionsEnrolledMonthly} Classes',
                  color: const Color(0xFFfff3e0),
                  textColor: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // Helper to get today's total sessions from dayWiseAttendanceList
  int _getTodayTotalSessions(StudentAttendanceController controller) {
    final today = DateTime.now();
    final todayData = controller.dayWiseAttendanceList.firstWhereOrNull(
      (data) =>
          data.date.year == today.year &&
          data.date.month == today.month &&
          data.date.day == today.day,
    );
    // The API response doesn't directly provide 'total_sessions_enrolled_today'.
    // We can infer it if percentage and present sessions are available for today.
    // For now, returning a placeholder or deriving if possible.
    // If percentage is not 0 and present sessions is not 0, then total sessions = (present sessions / percentage) * 100
    if (todayData != null &&
        todayData.percentage > 0 &&
        controller.attendanceSummary.value?.totalSessionsPresentToday != null) {
      return ((controller.attendanceSummary.value!.totalSessionsPresentToday /
                  todayData.percentage) *
              100)
          .round();
    }
    return 0; // Default if not enough data to infer
  }
}

class AttendanceChip extends StatelessWidget {
  final String label;
  final String subLabel;
  final Color color;
  final Color textColor;

  const AttendanceChip({
    super.key,
    required this.label,
    required this.subLabel,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,

        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subLabel,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassesAttendedRow extends StatelessWidget {
  final int totalSessionsEnrolled;
  const ClassesAttendedRow({super.key, required this.totalSessionsEnrolled});

  @override
  Widget build(BuildContext context) {
    final StudentAttendanceController controller = Get.find();
    final summary = controller.attendanceSummary.value;

    if (summary == null) {
      return const SizedBox.shrink(); // Or a loading indicator
    }
    // Assuming 'Present', 'Late', 'Leave' percentages are derived or hardcoded for now
    // As per the provided API, we only have overall present percentages.
    // For the progress bar, we'll use the overall percentage for the 'Present' part.
    // The 'Late' and 'Leave' parts would require more detailed API data.
    // For now, let's use a simplified representation based on the overall percentage.
    final double presentPercentage = summary.attendanceOverallPercentage / 100;
    // Dummy values for late/leave for visual representation if not in API
    final double latePercentage =
        0.0; // No specific data in API for this breakdown
    final double leavePercentage =
        0.0; // No specific data in API for this breakdown

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top Row: Label + Count
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Classes Attended',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                summary.totalSessionsEnrolled.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        /// Progress Bar with Legend
        SizedBox(
          height: 20,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Full bar
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              // Present bar (Blue)
              FractionallySizedBox(
                widthFactor: presentPercentage,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),

              // Late bar (Yellow) on top of blue
              FractionallySizedBox(
                widthFactor: latePercentage, // total 89%
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),

              // Leave bar (Red) on top of previous
              FractionallySizedBox(
                widthFactor: leavePercentage, // total 85%
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),

              // Min. required marker (small vertical line)
              Positioned(
                left: MediaQuery.of(context).size.width * 0.85,
                child: Container(height: 16, width: 2, color: Colors.black87),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        /// Attendance Legend
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AttendanceLegend(color: Colors.blue, label: 'Present'),
              AttendanceLegend(color: Colors.orange, label: 'Late'),
              AttendanceLegend(color: Colors.redAccent, label: 'Leave'),
              AttendanceLegend(color: Colors.green, label: 'Min. Required'),
            ],
          ),
        ),
      ],
    );
  }
}

class AttendanceLegend extends StatelessWidget {
  final Color color;
  final String label;

  const AttendanceLegend({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
