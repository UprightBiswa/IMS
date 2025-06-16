class AttendanceSubjectModel {
  final String subject;
  final int total;
  final int present;
  final double percentage;
  final String status; // Good, Warning, Critical

  AttendanceSubjectModel({
    required this.subject,
    required this.total,
    required this.present,
    required this.percentage,
    required this.status,
  });
}
