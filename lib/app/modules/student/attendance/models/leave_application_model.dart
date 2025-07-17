import 'package:intl/intl.dart';

class LeaveApplicationModel {
  final int id;
  final int userId;
  final String leaveType;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final String reason;
  final List<String> supportingDocuments;
  final String? adminComments;
  final String? facultyComments;
  final String? finalStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  LeaveApplicationModel({
    required this.id,
    required this.userId,
    required this.leaveType,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.reason,
    required this.supportingDocuments,
    this.adminComments,
    this.facultyComments,
    this.finalStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LeaveApplicationModel.fromJson(Map<String, dynamic> json) {
    return LeaveApplicationModel(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      leaveType: json['leave_type'] as String,
      status: json['status'] as String,
      startDate: DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'').parse(json['start_date']),
      endDate: DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'').parse(json['end_date']),
      totalDays: json['total_days'] as int,
      reason: json['reason'] as String,
      supportingDocuments: List<String>.from(json['supporting_documents'] as List),
      adminComments: json['admin_comments'] as String?,
      facultyComments: json['faculty_comments'] as String?,
      finalStatus: json['final_status'] as String?,
      createdAt: DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'').parse(json['created_at']),
      updatedAt: DateFormat('EEE, dd MMM yyyy HH:mm:ss \'GMT\'').parse(json['updated_at']),
    );
  }
}