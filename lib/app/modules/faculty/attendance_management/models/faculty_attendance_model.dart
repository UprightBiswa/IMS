import 'package:flutter/material.dart';

class MonthlyAttendanceSummary {
  final int present;
  final int absent;
  final int late;
  final int leave;
  final double requiredPercentage;
  final String complianceMessage; // E.g., "77.6%"

  MonthlyAttendanceSummary({
    required this.present,
    required this.absent,
    required this.late,
    required this.leave,
    required this.requiredPercentage,
    required this.complianceMessage,
  });

  static MonthlyAttendanceSummary dummy() {
    return MonthlyAttendanceSummary(
      present: 21,
      absent: 2,
      late: 1,
      leave: 3,
      requiredPercentage: 85.0,
      complianceMessage: "77.6%",
    );
  }
}

class CalendarDayStatus {
  final DateTime date;
  final int status;

  CalendarDayStatus({required this.date, required this.status});
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
