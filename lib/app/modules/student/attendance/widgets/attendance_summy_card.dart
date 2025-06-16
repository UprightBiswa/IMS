import 'package:flutter/material.dart';

import '../../home/widgets/attendance_summary.dart';
import '../../home/widgets/dashboard_summary_card.dart';

class AttendanceSummaryCard extends StatelessWidget {
  const AttendanceSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSummaryCard(
      title: "Attendance Summary",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// User Info and Attendance Circle
          Row(
            children: [
              // Name and Roll
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isha Sharma',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Roll No: Btech-123',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              // Attendance Percentage
              SummaryPersentage(),
            ],
          ),

          const SizedBox(height: 20),

          ClassesAttendedRow(),

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
            children: const [
              AttendanceChip(
                label: '80%',
                subLabel: 'Today\n4/5 Classes',
                color: Color(0xFFe3f2fd),
                textColor: Colors.blue,
              ),
              AttendanceChip(
                label: '89%',
                subLabel: 'Week\n16/18 Classes',
                color: Color(0xFFe8f5e9),
                textColor: Colors.green,
              ),
              AttendanceChip(
                label: '85%',
                subLabel: 'Month\n68/80 Classes',
                color: Color(0xFFfff3e0),
                textColor: Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
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
  const ClassesAttendedRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top Row: Label + Count
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Classes Attended',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text('69', style: TextStyle(fontWeight: FontWeight.bold)),
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
                widthFactor: 0.8, // 80%
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
                widthFactor: 0.89, // total 89%
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
                widthFactor: 0.85, // total 85%
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
