class StudentClassSnapshotModel {
  final String className;
  final int avgAttendance;
  final int totalStudents;
  final int studentsBelow75;
  final String status;

  StudentClassSnapshotModel({
    required this.className,
    required this.avgAttendance,
    required this.totalStudents,
    required this.studentsBelow75,
    required this.status,
  });

  factory StudentClassSnapshotModel.fromJson(Map<String, dynamic> json) {
    return StudentClassSnapshotModel(
      className: json['class_name'],
      avgAttendance: json['avg_attendance_percentage'],
      totalStudents: json['total_students'],
      studentsBelow75: json['students_lt_75'],
      status: json['status'],
    );
  }
}
