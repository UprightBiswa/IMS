import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../theme/app_colors.dart';
import '../../controllers/admin_attendance_controller.dart';
import '../../models/faculty_overview_model.dart';
import '../../widgets/analytics_pill_widget.dart';

class FacultyTab extends StatelessWidget {
  const FacultyTab({super.key});

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
          } else if (controller.facultyData.isEmpty) {
            return const Center(child: Text("No faculty data available."));
          }

          return _buildFacultyOverview(controller.facultyData);
        }),
        const SizedBox(height: 16),
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
              Row(
                children: [
                  const Icon(Icons.analytics_outlined, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Faculty Attendance Analytics',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnalyticsPillWidget(
                    title: 'Physics',
                    value: '96%',
                    subtitle: '6 of 6 classes marked',
                    icon: Icons.bar_chart_outlined,
                    persentage: 0.96,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: 8),

                  AnalyticsPillWidget(
                    title: 'Chemistry',
                    value: '82%',
                    subtitle: '8 of 10 classes marked',
                    icon: Icons.bar_chart_outlined,
                    persentage: 0.82,
                    color: AppColors.accentYellow,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AnalyticsPillWidget(
                    title: 'Mathematics',
                    value: '80%',
                    subtitle: '8 of 10 classes marked',
                    icon: Icons.bar_chart_outlined,
                    persentage: 0.80,
                    color: AppColors.accentGreen,
                  ),
                  const SizedBox(width: 8),

                  AnalyticsPillWidget(
                    title: 'Computer Science',
                    value: '88%',
                    subtitle: '8 of 9 classes marked',
                    icon: Icons.bar_chart_outlined,
                    persentage: 0.88,
                    color: AppColors.accentRed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFacultyOverview(List<FacultyOverviewModel> data) {
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
                'Faculty Attendance Overview',
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
                  0: FlexColumnWidth(2.5),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(1.5),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    children: [
                      _buildTableHeaderCell('FACULTY NAME'),
                      _buildTableHeaderCell('DEPARTMENT'),
                      _buildTableHeaderCell('CLASS ASSIGNED'),
                      _buildTableHeaderCell('CLASSES MARKED'),
                      _buildTableHeaderCell('STATUS'),
                    ],
                  ),
                ],
              ),
              // Table Rows
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2.5),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5),
                  4: FlexColumnWidth(1.5),
                },
                children: data.map((faculty) {
                  return TableRow(
                    children: [
                      _buildTableCell(faculty.facultyName),
                      _buildTableCell(faculty.department),
                      _buildTableCell(faculty.classesAssigned.toString()),
                      _buildTableCell(faculty.classesMarked.toString()),
                      _buildStatusStyledCell(faculty.status),
                    ],
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

  static Widget _buildStatusStyledCell(String status) {
    Color bgColor = Colors.grey.withValues(alpha: 0.1);
    Color textColor = Colors.black87;

    if (status.contains("> 85")) {
      bgColor = AppColors.accentGreen.withValues(alpha: 0.1);
      textColor = AppColors.accentGreen;
    } else if (status.contains("75-84")) {
      bgColor = AppColors.accentYellow.withValues(alpha: 0.1);
      textColor = AppColors.accentYellow;
    } else if (status.contains("< 75")) {
      bgColor = AppColors.accentRed.withValues(alpha: 0.1);
      textColor = AppColors.accentRed;
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
          child: Text(
            status,
            style: TextStyle(
              fontSize: 9,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
}
