import 'package:attendance_demo/app/modules/admin/attendance_management/models/student_class_snap_shot_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../theme/app_colors.dart';
import '../../controllers/admin_attendance_controller.dart';
import '../../widgets/trend_analysis_chart.dart';

class StudentTab extends StatelessWidget {
  const StudentTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AttendanceDashboardController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          } else if (controller.studentClassSnapshot.isEmpty) {
            return const Center(child: Text("No student data available."));
          }

          return _buildClassAttendanceSnapshot(controller.studentClassSnapshot);
        }),
        const SizedBox(height: 16),
        _buildAttendanceAlerts(),
        const SizedBox(height: 16),
        const AttendanceTrendAnalyticsGraph(),
      ],
    );
  }

  Widget _buildClassAttendanceSnapshot(List<StudentClassSnapshotModel> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Class Attendance Snapshot',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        style: TextStyle(fontSize: 10),
                        decoration: InputDecoration(
                          hintText: 'Search Students...',
                          hintStyle: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(Icons.search, size: 16),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      // Handle filter action
                      // ADMIN_LEAVE_MANAGEMENT
                      Get.to(() => Routes.ADMIN_LEAVE_MANAGEMENT);
                    },
                    child: Container(
                      height: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: .5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.filter_alt_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          const Text('Filter', style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      // Handle date selection action
                    },
                    child: Container(
                      height: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: .5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text('Date', style: TextStyle(fontSize: 10)),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Table Header
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1.4),
                  2: FlexColumnWidth(1.4),
                  3: FlexColumnWidth(1.4),
                  4: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    children: [
                      _buildTableHeaderCell('CLASS'),
                      _buildTableHeaderCell('AVG. ATTENDANCE'),
                      _buildTableHeaderCell('STUDENTS ABSENT'),
                      _buildTableHeaderCell('TOTAL STUDENTS'),
                      _buildTableHeaderCell('STATUS'),
                    ],
                  ),
                ],
              ),
              // Table Rows
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1.4),
                  2: FlexColumnWidth(1.4),
                  3: FlexColumnWidth(1.4),
                  4: FlexColumnWidth(2),
                },
                children: data.map((student) {
                  return TableRow(
                    children: [
                      _buildTableCell(student.className ?? ''),
                      _buildTableCell(
                        '${student.avgAttendance?.toStringAsFixed(0) ?? 'N/A'}%',
                      ), // Format to 0 decimal places and add %
                      _buildTableCell(
                        student.studentsBelow75Percent?.toString() ?? 'N/A',
                      ),
                      _buildTableCell(
                        student.totalStudents?.toString() ?? 'N/A',
                      ),
                      _buildStatusTableCell(
                        student.displayStatusText ?? 'N/A',
                      ), // Use derived status text
                    ],
                    // children: [
                    //   _buildTableCell(student.className.toString()),
                    //   _buildTableCell(student.avgAttendance.toString()),
                    //   _buildTableCell(
                    //     student.studentsBelow75Percent.toString(),
                    //   ),
                    //   _buildTableCell(student.totalStudents.toString()),
                    //   _buildStatusTableCell(student.status ?? 'N/A'),
                    // ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(color: AppColors.primaryBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceAlerts() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.notifications_none_rounded, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      'Attendance Alerts',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // count//
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '3',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAlertCardV2(
            icon: Icons.error_outline,
            iconColor: AppColors.primaryRed,
            title: 'Critical Attendance Alert',
            description:
                'Rahul Sharma (B.Sc. 1A) has less than 75% attendance in 4 classes.',
            actionText: 'Contact Students',
            onActionTap: () {},
            backgroundColor: AppColors.primaryRed.withValues(
              alpha: 0.05,
            ), // Very light red
            textColor: Colors.black87,
          ),
          const SizedBox(height: 12),
          _buildAlertCardV2(
            icon: Icons.warning_amber_rounded,
            iconColor: AppColors.primaryOrange,
            title: 'Warning Alert',
            description:
                '5 students in B.Sc. 1A are below 70% attendance threshold',
            actionText: 'View Details',
            onActionTap: () {},
            backgroundColor: AppColors.primaryOrange.withValues(
              alpha: 0.05,
            ), // Very light orange
            textColor: Colors.black87,
          ),
        ],
      ),
    );
  }

  static Widget _buildTableHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  static Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 9, color: Colors.black87),
      ),
    );
  }

  // // Custom cell for status (Student Class, Faculty Overview)
  // static Widget _buildStatusTableCell(String status) {
  //   Color bgColor = Colors.grey.withValues(alpha: .1);
  //   Color textColor = Colors.black87;

  //   if (status.contains("> 85")) {
  //     bgColor = AppColors.accentGreen.withValues(alpha: .1);
  //     textColor = AppColors.accentGreen;
  //   } else if (status.contains("75-84")) {
  //     bgColor = AppColors.accentYellow.withValues(alpha: .1);
  //     textColor = AppColors.accentYellow;
  //   } else if (status.contains("< 75")) {
  //     bgColor = AppColors.accentRed.withValues(alpha: .1);
  //     textColor = AppColors.accentRed;
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4.0),
  //     child: Align(
  //       alignment: Alignment.center,
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //         decoration: BoxDecoration(
  //           color: bgColor,
  //           borderRadius: BorderRadius.circular(4),
  //         ),
  //         child: Text(
  //           status,
  //           style: TextStyle(
  //             fontSize: 9,
  //             color: textColor,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Custom cell for status (Student Class, Faculty Overview)
  // static Widget _buildStatusTableCell(String status) {
  //   Color bgColor;
  //   Color textColor;
  //   String displayStatus = status; // Default to API status string

  //   switch (status) {
  //     case "good":
  //       bgColor = AppColors.accentGreen.withOpacity(
  //         0.1,
  //       ); // Using withOpacity for a lighter background
  //       textColor = AppColors.accentGreen;
  //       displayStatus = "Good"; // Display "Good" instead of "good"
  //       break;
  //     case "needs_attention":
  //       bgColor = AppColors.accentRed.withOpacity(
  //         0.1,
  //       ); // Using withOpacity for a lighter background
  //       textColor = AppColors.accentRed;
  //       displayStatus = "Needs Attention"; // Display "Needs Attention"
  //       break;
  //     default:
  //       bgColor = Colors.grey.withOpacity(0.1);
  //       textColor = Colors.black87;
  //       break;
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4.0),
  //     child: Align(
  //       alignment: Alignment.center,
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //         decoration: BoxDecoration(
  //           color: bgColor,
  //           borderRadius: BorderRadius.circular(4),
  //         ),
  //         child: Row(
  //           // Use Row to place icon and text
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Icon(
  //               Icons.circle,
  //               size: 8,
  //               color: textColor,
  //             ), // Small circle icon
  //             const SizedBox(width: 4),
  //             Text(
  //               displayStatus, // Use the formatted displayStatus
  //               style: TextStyle(
  //                 fontSize: 10,
  //                 color: textColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  // Custom cell for status (Student Class, Faculty Overview)
  static Widget _buildStatusTableCell(String displayStatusText) {
    Color bgColor;
    Color textColor;

    switch (displayStatusText) {
      case "> 85%":
        bgColor = AppColors.accentGreen.withOpacity(0.1);
        textColor = AppColors.accentGreen;
        break;
      case "75-84%":
        bgColor = AppColors.accentYellow.withOpacity(0.1);
        textColor = AppColors.accentYellow;
        break;
      case "< 75%":
        bgColor = AppColors.accentRed.withOpacity(0.1);
        textColor = AppColors.accentRed;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.black87;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, size: 8, color: textColor),
              const SizedBox(width: 4),
              Text(
                displayStatusText,
                style: TextStyle(fontSize: 8, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A more generalized alert card widget for the alert section
  Widget _buildAlertCardV2({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    String? actionText,
    VoidCallback? onActionTap,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: backgroundColor.withValues(alpha: .2),
          width: .6,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: iconColor, size: 10),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 8,
                    color: textColor.withValues(alpha: .7),
                  ),
                ),
              ],
            ),
          ),
          if (actionText != null && onActionTap != null) ...[
            const SizedBox(width: 8),
            Align(
              alignment:
                  Alignment.bottomRight, // Align action to right as per image
              child: GestureDetector(
                onTap: onActionTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      width: .6,
                      color: Colors.grey.withValues(alpha: .3),
                    ),
                  ),
                  child: Text(
                    actionText,
                    style: TextStyle(
                      fontSize: 8,
                      color: textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
