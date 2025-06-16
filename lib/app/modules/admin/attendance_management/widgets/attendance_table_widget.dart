import 'package:flutter/material.dart';
import '../models/attendance_subject_model.dart';

class AttendanceTableWidget extends StatelessWidget {
  final List<AttendanceSubjectModel> data;

  const AttendanceTableWidget({super.key, required this.data});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Good':
        return Colors.green;
      case 'Warning':
        return Colors.orange;
      case 'Critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(child: Text("Subject", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text("Total", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text("Present", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text("%", style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          const Divider(),
          // Data Rows
          ...data.map((subject) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(subject.subject)),
                    Expanded(child: Text('${subject.total}')),
                    Expanded(child: Text('${subject.present}')),
                    Expanded(child: Text('${subject.percentage.toStringAsFixed(1)}%')),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(subject.status).withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          subject.status,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _getStatusColor(subject.status),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
