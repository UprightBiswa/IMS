import 'package:get/get.dart';

class OverallStudentAttendanceSummary {
  final int totalStudents;
  final int presentToday;
  final int absentStudents;
  final int lateStudent;
  final double weeklyAttendanceRate;
  final int belowThresholdStudents; // For "Students Who < 75% attendance"

  OverallStudentAttendanceSummary({
    required this.totalStudents,
    required this.presentToday,
    required this.absentStudents,
    required this.lateStudent,

    required this.weeklyAttendanceRate,
    required this.belowThresholdStudents,
  });

  factory OverallStudentAttendanceSummary.fromJson(Map<String, dynamic> json) {
    final int total = json['total_students'] ?? 0;
    final double present = (json['present'] ?? 0).toDouble();
    final double absent = (json['absent'] ?? 0).toDouble();
    final double late = (json['late'] ?? 0).toDouble();

    return OverallStudentAttendanceSummary(
      totalStudents: total,
      presentToday: ((present * total) / 100).round(),
      absentStudents: ((absent * total) / 100).round(),
      lateStudent: ((late * total) / 100).round(),
      weeklyAttendanceRate: present,
      belowThresholdStudents: json['students_with_lt_75_percentage'] ?? 0,
    );
  }
}

// Class-wise Attendance Snapshot
class ClassAttendanceSnapshot {
  final String className;
  final double attendancePercentage;
  final int totalStudents;

  ClassAttendanceSnapshot({
    required this.className,
    required this.attendancePercentage,
    required this.totalStudents,
  });

  factory ClassAttendanceSnapshot.fromJson(Map<String, dynamic> json) {
    return ClassAttendanceSnapshot(
      className: json['course_name'] ?? '',
      attendancePercentage: (json['attendance_percentage'] as num).toDouble(),
      totalStudents: json['number_of_students'],
    );
  }
}

// Recent Class for marking
class RecentClass {
  final String courseName;
  final String subject;
  final DateTime date;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int totalStudents;

  RecentClass({
    required this.courseName,
    required this.subject,
    required this.date,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.totalStudents,
  });

  factory RecentClass.fromJson(Map<String, dynamic> json) {
    return RecentClass(
      courseName: json['course_name'] ?? '',
      subject: json['subject_name'] ?? '',
      date: DateTime.parse(json['date']),
      presentCount: json['students_present'],
      absentCount: json['students_absent'],
      lateCount: json['students_late'],
      totalStudents:
          json['students_present'] +
          json['students_absent'] +
          json['students_late'],
    );
  }
}

class StudentBasicInfo {
  final String rollNumber;
  final String name;
  final String status; // Fake status

  StudentBasicInfo({
    required this.rollNumber,
    required this.name,
    required this.status,
  });

  factory StudentBasicInfo.fromJson(Map<String, dynamic> json) {
    return StudentBasicInfo(
      rollNumber: json['roll_number'],
      name: json['student_name'],
      status: _generateRandomStatus(), // Assign a random status
    );
  }

  static String _generateRandomStatus() {
    final statuses = ['Present', 'Absent', 'Late'];
    statuses.shuffle();
    return statuses.first;
  }
}

// Student for Mark Attendance list
class StudentAttendanceMark {
  final String id;
  final String rollNo;
  final String name;
  Rx<String>
  status; // "Present", "Absent", "Late", "Leave" or initially "Unmarked"

  StudentAttendanceMark({
    required this.id,
    required this.rollNo,
    required this.name,
    String initialStatus = 'Unmarked',
  }) : status = initialStatus.obs;

  static List<StudentAttendanceMark> dummyList() {
    return [
      StudentAttendanceMark(
        id: 'S001',
        rollNo: '801',
        name: 'Anjal Sharma',
        initialStatus: 'Present',
      ),
      StudentAttendanceMark(
        id: 'S002',
        rollNo: '802',
        name: 'Rohit Mehta',
        initialStatus: 'Absent',
      ),
      StudentAttendanceMark(
        id: 'S003',
        rollNo: '803',
        name: 'Priya Deshmukh',
        initialStatus: 'Present',
      ),
      StudentAttendanceMark(
        id: 'S004',
        rollNo: '804',
        name: 'Vikram Singh',
        initialStatus: 'Present',
      ),
      StudentAttendanceMark(
        id: 'S05',
        rollNo: '805',
        name: 'Nisha Patel',
        initialStatus: 'Late',
      ),
      StudentAttendanceMark(
        id: 'S06',
        rollNo: '806',
        name: 'Arjun Kumar',
        initialStatus: 'Absent',
      ),
      StudentAttendanceMark(
        id: 'S07',
        rollNo: '807',
        name: 'Sneha Gupta',
        initialStatus: 'Present',
      ),
    ];
  }
}

// Student Attendance Record (for Attendance Records tab)
class StudentRecord {
  final String rollNo;
  final String name;
  final String section;
  final String subject;
  final DateTime date;
  final String status; // "Present", "Absent", "Late", "Leave"

  StudentRecord({
    required this.rollNo,
    required this.name,
    required this.section,
    required this.subject,
    required this.date,
    required this.status,
  });

  static List<StudentRecord> dummyList() {
    return [
      StudentRecord(
        rollNo: '801',
        name: 'Anjali Sharma',
        section: 'A',
        subject: 'Mechanics',
        date: DateTime(2025, 3, 27),
        status: 'Present',
      ),
      StudentRecord(
        rollNo: '802',
        name: 'Rohit Mehta',
        section: 'A',
        subject: 'Mechanics',
        date: DateTime(2025, 3, 27),
        status: 'Absent',
      ),
      StudentRecord(
        rollNo: '803',
        name: 'Priya Deshmukh',
        section: 'A',
        subject: 'Mechanics',
        date: DateTime(2025, 3, 27),
        status: 'Present',
      ),
      StudentRecord(
        rollNo: '804',
        name: 'Vikram Singh',
        section: 'A',
        subject: 'Mechanics',
        date: DateTime(2025, 3, 27),
        status: 'Late',
      ),
      StudentRecord(
        rollNo: '805',
        name: 'Nisha Patel',
        section: 'A',
        subject: 'Mechanics',
        date: DateTime(2025, 3, 27),
        status: 'Present',
      ),
      StudentRecord(
        rollNo: '806',
        name: 'Arjun',
        section: 'A',
        subject: 'Mechanics',
        date: DateTime(2025, 3, 27),
        status: 'Absent',
      ),
      StudentRecord(
        rollNo: '807',
        name: 'Sneha',
        section: 'A',
        subject: 'Mechanics',
        date: DateTime(2025, 3, 27),
        status: 'Present',
      ),
    ];
  }
}
