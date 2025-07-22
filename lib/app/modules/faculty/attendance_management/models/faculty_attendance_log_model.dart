// NEW Model: lib/app/modules/faculty/attendance_management/models/faculty_attendance_log_model.dart

import 'package:intl/intl.dart';

class AttendanceLogEntry {
  final DateTime date;
  final String status; // e.g., 'Present', 'Absent', 'Late', 'Leave'
  final DateTime? inTime;
  final DateTime? outTime;
  final String? note; // Reason for leave, late, etc.

  AttendanceLogEntry({
    required this.date,
    required this.status,
    this.inTime,
    this.outTime,
    this.note,
  });

  factory AttendanceLogEntry.fromJson(Map<String, dynamic> json) {
    return AttendanceLogEntry(
      date: DateFormat('yyyy-MM-dd').parse(json['date']),
      status: json['status'] as String,
      inTime: json['in_time'] != null ? DateFormat('HH:mm:ss').parse(json['in_time']) : null,
      outTime: json['out_time'] != null ? DateFormat('HH:mm:ss').parse(json['out_time']) : null,
      note: json['note'] as String?,
    );
  }

  static List<AttendanceLogEntry> dummyList() {
    return [
      AttendanceLogEntry(
        date: DateTime(2025, 5, 19),
        status: 'Present',
        inTime: DateTime(2025, 1, 1, 9, 0),
        outTime: DateTime(2025, 1, 1, 17, 30),
        note: null,
      ),
      AttendanceLogEntry(
        date: DateTime(2025, 5, 18),
        status: 'Late',
        inTime: DateTime(2025, 1, 1, 9, 45),
        outTime: DateTime(2025, 1, 1, 17, 15),
        note: 'Arrived late',
      ),
      AttendanceLogEntry(
        date: DateTime(2025, 5, 17),
        status: 'Present',
        inTime: DateTime(2025, 1, 1, 8, 55),
        outTime: DateTime(2025, 1, 1, 17, 0),
        note: null,
      ),
      AttendanceLogEntry(
        date: DateTime(2025, 5, 16),
        status: 'Leave',
        inTime: null,
        outTime: null,
        note: 'Medical leave',
      ),
      AttendanceLogEntry(
        date: DateTime(2025, 5, 15),
        status: 'Absent',
        inTime: null,
        outTime: null,
        note: null,
      ),
      AttendanceLogEntry(
        date: DateTime(2025, 5, 14),
        status: 'Present',
        inTime: DateTime(2025, 1, 1, 8, 50),
        outTime: DateTime(2025, 1, 1, 17, 0),
        note: null,
      ),
      AttendanceLogEntry(
        date: DateTime(2025, 5, 13),
        status: 'Present',
        inTime: DateTime(2025, 1, 1, 9, 5),
        outTime: DateTime(2025, 1, 1, 17, 30),
        note: null,
      ),
    ];
  }
}