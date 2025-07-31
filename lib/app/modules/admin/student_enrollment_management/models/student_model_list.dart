import 'package:flutter/material.dart';

class StudentModelList {
  final String name;
  final String department;
  final String status;
  final String? studentId;
  final String? password;

  StudentModelList({
    required this.name,
    required this.department,
    required this.status,
    this.studentId,
    this.password,
  });

  // For dynamic text color
  get statusColor {
    switch (status.toLowerCase()) {
      case 'present':
        return const Color(0xFF2ECC71); // green
      case 'working':
        return const Color(0xFFF1C40F); // yellow
      case 'absent':
        return const Color(0xFFE74C3C); // red
      default:
        return const Color(0xFF34495E); // default gray
    }
  }
}
