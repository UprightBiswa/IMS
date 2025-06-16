import 'package:get/get.dart';

class OverallStudentAttendanceSummary {
  final int totalStudents;
  final int presentToday;
  final int absentStudents;
  final double weeklyAttendanceRate;
  final int belowThresholdStudents; // For "Students Who < 75% attendance"

  OverallStudentAttendanceSummary({
    required this.totalStudents,
    required this.presentToday,
    required this.absentStudents,
    required this.weeklyAttendanceRate,
    required this.belowThresholdStudents,
  });

  static OverallStudentAttendanceSummary dummy() {
    return OverallStudentAttendanceSummary(
      totalStudents: 1245,
      presentToday: 1142,
      absentStudents: 100, // For "8% of total"
      weeklyAttendanceRate: 98.3,
      belowThresholdStudents: 12, // Corresponds to "12 Students" in UI
    );
  }
}

// Class-wise Attendance Snapshot
class ClassAttendanceSnapshot {
  final String className;
  final String section;
  final double attendancePercentage;
  final int studentsPresent;
  final int totalStudents;

  ClassAttendanceSnapshot({
    required this.className,
    required this.section,
    required this.attendancePercentage,
    required this.studentsPresent,
    required this.totalStudents,
  });

  static List<ClassAttendanceSnapshot> dummyList() {
    return [
      ClassAttendanceSnapshot(
          className: 'B.Sc Physics 2nd Year',
          section: 'Section A',
          attendancePercentage: 87.2,
          studentsPresent: 5,
          totalStudents: 38),
      ClassAttendanceSnapshot(
          className: 'B.Com 2B',
          section: 'Section B',
          attendancePercentage: 78.1,
          studentsPresent: 9,
          totalStudents: 47),
      ClassAttendanceSnapshot(
          className: 'B.Tech 3C',
          section: 'Section C',
          attendancePercentage: 90.7,
          studentsPresent: 2,
          totalStudents: 39),
      ClassAttendanceSnapshot(
          className: 'BBA 2A',
          section: 'Section A',
          attendancePercentage: 72.8,
          studentsPresent: 14,
          totalStudents: 42),
    ];
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
  final int totalStudents; // To calculate unmarked

  RecentClass({
    required this.courseName,
    required this.subject,
    required this.date,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.totalStudents,
  });

  int get unmarkedCount => totalStudents - (presentCount + absentCount + lateCount);

  static List<RecentClass> dummyList() {
    return [
      RecentClass(
        courseName: 'Quantum Mechanics',
        subject: 'BSc Physics 3rd Year',
        date: DateTime(2025, 5, 21),
        presentCount: 29,
        absentCount: 3,
        lateCount: 2,
        totalStudents: 34,
      ),
      RecentClass(
        courseName: 'Advanced Thermodynamics',
        subject: 'BSc Physics 3rd Year',
        date: DateTime(2025, 5, 20),
        presentCount: 32,
        absentCount: 3,
        lateCount: 0,
        totalStudents: 35,
      ),
      RecentClass(
        courseName: 'Organic Chemistry',
        subject: 'BSc Chemistry 1st Year',
        date: DateTime(2025, 5, 19),
        presentCount: 41,
        absentCount: 7,
        lateCount: 2,
        totalStudents: 50,
      ),
    ];
  }
}

// Student for Mark Attendance list
class StudentAttendanceMark {
  final String id;
  final String rollNo;
  final String name;
  Rx<String> status; // "Present", "Absent", "Late", "Leave" or initially "Unmarked"

  StudentAttendanceMark({
    required this.id,
    required this.rollNo,
    required this.name,
    String initialStatus = 'Unmarked',
  }) : status = initialStatus.obs;

  static List<StudentAttendanceMark> dummyList() {
    return [
      StudentAttendanceMark(id: 'S001', rollNo: '801', name: 'Anjal Sharma', initialStatus: 'Present'),
      StudentAttendanceMark(id: 'S002', rollNo: '802', name: 'Rohit Mehta', initialStatus: 'Absent'),
      StudentAttendanceMark(id: 'S003', rollNo: '803', name: 'Priya Deshmukh', initialStatus: 'Present'),
      StudentAttendanceMark(id: 'S004', rollNo: '804', name: 'Vikram Singh', initialStatus: 'Present'),
      StudentAttendanceMark(id: 'S05', rollNo: '805', name: 'Nisha Patel', initialStatus: 'Late'),
      StudentAttendanceMark(id: 'S06', rollNo: '806', name: 'Arjun Kumar', initialStatus: 'Absent'),
      StudentAttendanceMark(id: 'S07', rollNo: '807', name: 'Sneha Gupta', initialStatus: 'Present'),
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
      StudentRecord(rollNo: '801', name: 'Anjali Sharma', section: 'A', subject: 'Mechanics', date: DateTime(2025, 3, 27), status: 'Present'),
      StudentRecord(rollNo: '802', name: 'Rohit Mehta', section: 'A', subject: 'Mechanics', date: DateTime(2025, 3, 27), status: 'Absent'),
      StudentRecord(rollNo: '803', name: 'Priya Deshmukh', section: 'A', subject: 'Mechanics', date: DateTime(2025, 3, 27), status: 'Present'),
      StudentRecord(rollNo: '804', name: 'Vikram Singh', section: 'A', subject: 'Mechanics', date: DateTime(2025, 3, 27), status: 'Late'),
      StudentRecord(rollNo: '805', name: 'Nisha Patel', section: 'A', subject: 'Mechanics', date: DateTime(2025, 3, 27), status: 'Present'),
      StudentRecord(rollNo: '806', name: 'Arjun', section: 'A', subject: 'Mechanics', date: DateTime(2025, 3, 27), status: 'Absent'),
      StudentRecord(rollNo: '807', name: 'Sneha', section: 'A', subject: 'Mechanics', date: DateTime(2025, 3, 27), status: 'Present'),
    ];
  }
}