// models/faculty_attendance_model.dart

import 'package:flutter/material.dart';

class MonthlyAttendanceSummary {
  final int present;
  final int late;
  final int leave;
  final int absent;
  final double requiredPercentage;
  final String complianceMessage;

  MonthlyAttendanceSummary({
    required this.present,
    required this.late,
    required this.leave,
    required this.absent,
    required this.requiredPercentage,
    required this.complianceMessage,
  });

  factory MonthlyAttendanceSummary.fromJson(Map<String, dynamic> json) {
    return MonthlyAttendanceSummary(
      present: json['total_days_present'] ?? 0,
      late: json['late'] ?? 0,
      leave: json['leave'] ?? 0,
      absent: json['absent_days'] ?? 0,
      requiredPercentage: (json['required_attendance'] ?? 0).toDouble(),
      complianceMessage: "${json['summary_percentage']}%",
    );
  }
}

enum AttendanceType { present, absent, late, leave }

int getStatusCode(String status) {
  switch (status.toLowerCase()) {
    case 'present':
      return 1;
    case 'absent':
      return 2;
    case 'late':
      return 3;
    case 'leave':
      return 4;
    default:
      return 0;
  }
}


class CalendarDayStatus {
  final DateTime date;
  final String status;
  final String? reason;
  final String? checkIn;
  final String? checkOut;
  final String weekday;
  final int statusCode;

  CalendarDayStatus({
    required this.date,
    required this.status,
    this.reason,
    this.checkIn,
    this.checkOut,
    required this.weekday,
    required this.statusCode,
  });

  factory CalendarDayStatus.fromJson(Map<String, dynamic> json) {
    return CalendarDayStatus(
      date: DateTime.parse(json['date']),
      status: json['status'],
      reason: json['reason'],
      checkIn: json['check_in_time'],
      checkOut: json['check_out_time'],
      weekday: json['weekday'],
      statusCode: getStatusCode(json['status'].toString()),
    );
  }
}

class RecentActivity {
  final DateTime date;
  final String dayOfWeek;
  final String title;
  final String time;
  final String status;
  final IconData icon;

  RecentActivity({
    required this.date,
    required this.dayOfWeek,
    required this.title,
    required this.time,
    required this.status,
    required this.icon,
  });

  static List<RecentActivity> dummyList() {
    return [
      RecentActivity(
        date: DateTime(2025, 5, 21),
        dayOfWeek: 'Wednesday',
        title: 'BMGT 321',
        time: '08:02 AM\n04:55 PM',
        status: 'Present',
        icon: Icons.check_circle_outline,
      ),
      RecentActivity(
        date: DateTime(2025, 5, 20),
        dayOfWeek: 'Tuesday',
        title: 'DESGN 401',
        time: '08:58 AM\n05:03 PM',
        status: 'Present',
        icon: Icons.check_circle_outline,
      ),
      RecentActivity(
        date: DateTime(2025, 5, 19),
        dayOfWeek: 'Monday',
        title: 'Late Entry',
        time: '10:15 AM\n06:00 PM',
        status: 'Late',
        icon: Icons.access_time,
      ),
      RecentActivity(
        date: DateTime(2025, 5, 18),
        dayOfWeek: 'Sunday',
        title: 'Personal Leave',
        time: 'Full Day',
        status: 'Absent',
        icon: Icons.cancel_outlined,
      ),
      RecentActivity(
        date: DateTime(2025, 5, 17),
        dayOfWeek: 'Saturday',
        title: 'Unmarked',
        time: 'Full Day',
        status: 'Unmarked',
        icon: Icons.remove_circle_outline,
      ),
    ];
  }
}
