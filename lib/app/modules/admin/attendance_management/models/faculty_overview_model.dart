// Step 2: Model Classes
class FacultyOverviewModel {
  final String facultyName;
  final String department;
  final int classesAssigned;
  final int classesMarked;
  final String status;

  FacultyOverviewModel({
    required this.facultyName,
    required this.department,
    required this.classesAssigned,
    required this.classesMarked,
    required this.status,
  });

  factory FacultyOverviewModel.fromJson(Map<String, dynamic> json) => FacultyOverviewModel(
        facultyName: json['faculty_name'],
        department: json['department'],
        classesAssigned: json['classes_assigned'],
        classesMarked: json['classes_marked'],
        status: json['status'],
      );
}
