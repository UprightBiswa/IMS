import 'package:flutter/material.dart';

import '../../../../../theme/app_colors.dart';
import '../../widgets/analytics_pill_widget.dart';

class FacultyTab extends StatelessWidget {
  const FacultyTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> facultyOverviewData = [
      {
        "FACULTY NAME": "Dr. Meena Rao",
        "DEPARTMENT": "Physics",
        "CLASS ASSIGNED": 4,
        "CLASSES MARKED": 4,
        "STATUS": 1,
      },
      {
        "FACULTY NAME": "Mr. Sanjay Jain",
        "DEPARTMENT": "Chemistry",
        "CLASS ASSIGNED": 4,
        "CLASSES MARKED": 2,
        "STATUS": 0,
      },
      {
        "FACULTY NAME": "Dr. Priya Singh",
        "DEPARTMENT": "Computer Science",
        "CLASS ASSIGNED": 3,
        "CLASSES MARKED": 3,
        "STATUS": 1,
      },
      {
        "FACULTY NAME": "Dr. Ankit Kumar",
        "DEPARTMENT": "Business Administration",
        "CLASS ASSIGNED": 4,
        "CLASSES MARKED": 3,
        "STATUS": 2,
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFacultyOverview(facultyOverviewData),
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

  Widget _buildFacultyOverview(List<Map<String, dynamic>> data) {
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
                children: data.map((row) {
                  return TableRow(
                    children: [
                      _buildTableCell(row['FACULTY NAME'].toString()),
                      _buildTableCell(row['DEPARTMENT'].toString()),
                      _buildTableCell(row['CLASS ASSIGNED'].toString()),
                      _buildTableCell(row['CLASSES MARKED'].toString()),
                      _buildStatusTableCell(row['STATUS']),
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

  // Custom cell for status (Student Class, Faculty Overview)
  static Widget _buildStatusTableCell(int statusIndex) {
    Color bgColor;
    Color textColor;
    String text;

    switch (statusIndex) {
      case 0: // Orange for low attendance/pending
        bgColor = AppColors.accentYellow.withValues(alpha: .1);
        textColor = AppColors.accentYellow;
        text = '~70%'; // Example
        break;
      case 1: // Green for good attendance
        bgColor = AppColors.accentGreen.withValues(alpha: .1);
        textColor = AppColors.accentGreen;
        text = '>75%'; // Example
        break;
      case 2: // Red for very low attendance
        bgColor = AppColors.accentRed.withValues(alpha: .1);
        textColor = AppColors.accentRed;
        text = '<75%'; // Example
        break;
      default:
        bgColor = Colors.grey.withValues(alpha: .1);
        textColor = Colors.grey;
        text = 'N/A';
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
            text,
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
