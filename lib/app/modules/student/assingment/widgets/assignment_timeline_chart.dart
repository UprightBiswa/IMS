// lib/app/modules/assignments/widgets/assignment_timeline_chart.dart
import 'package:flutter/material.dart';

class AssignmentTimelineChart extends StatelessWidget {
  final List<int> timelineData; // 0: No assignment, 1: Completed, 2: Pending/Missed

  const AssignmentTimelineChart({super.key, required this.timelineData});

  Color getBarColor(int status) {
    switch (status) {
      case 1:
        return Colors.green; // Completed
      case 2:
        return Colors.orange; // Pending/Missed
      case 0:
        return Colors.grey.shade300; // No assignment
      default:
        return Colors.transparent; // Should not happen with valid data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.03)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Assignment Timeline - Last 17 Days',
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
            crossAxisAlignment: CrossAxisAlignment.end, // Align bars at the bottom
            children: List.generate(17, (index) {
              // Ensure we don't go out of bounds if timelineData is shorter than 17
              final status = timelineData.length > index ? timelineData[index] : 0;
              final barColor = getBarColor(status);
              final barHeight = status != 0 ? 50.0 : 5.0; // Minimal height for 'no assignment'

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8, // Width of each bar
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4), // Space between bar and day number
                  Text(
                    '${index + 1}', // Day number
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 20),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(Colors.green, 'Completed'),
              _buildLegendItem(Colors.orange, 'Pending/Missed'),
              _buildLegendItem(Colors.grey.shade300, 'No Assignment'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}