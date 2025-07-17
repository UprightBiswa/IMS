// -----------------------------------------------------------------------------
// Models (lib/app/modules/admin/leave_management/models/admin_leave_application_model.dart)
// Reusing LeaveApplicationModel from student module for consistency,
// but placed in admin module for clarity.
// -----------------------------------------------------------------------------
import 'package:intl/intl.dart';

class AdminLeaveApplicationModel {
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
  final String? userName; // Assuming user name might be returned for admin view
  final String? userRole; // Assuming user role might be returned for admin view
  final String? userDepartment; // Assuming user department might be returned for admin view

  AdminLeaveApplicationModel({
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
    this.userName,
    this.userRole,
    this.userDepartment,
  });

  factory AdminLeaveApplicationModel.fromJson(Map<String, dynamic> json) {
    return AdminLeaveApplicationModel(
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
      userName: json['user_name'] as String?, // Assuming these fields exist in API response
      userRole: json['user_role'] as String?,
      userDepartment: json['user_department'] as String?,
    );
  }

  // Dummy list for initial display
  static List<AdminLeaveApplicationModel> dummyList() {
    return [
      AdminLeaveApplicationModel(
        id: 7,
        userId: 6,
        leaveType: 'sick',
        status: 'pending',
        startDate: DateTime(2025, 8, 21),
        endDate: DateTime(2025, 8, 21),
        totalDays: 1,
        reason: 'Fever and need medical rest for recovery. Doctor advised complete bed rest.',
        supportingDocuments: ['medical_certificate.pdf'],
        createdAt: DateTime(2025, 7, 17, 6, 25, 18),
        updatedAt: DateTime(2025, 7, 17, 6, 25, 18),
        userName: 'Dr. Ravi Kumar',
        userRole: 'Professor',
        userDepartment: 'Physics',
      ),
      AdminLeaveApplicationModel(
        id: 6,
        userId: 6,
        leaveType: 'sick',
        status: 'pending',
        startDate: DateTime(2025, 8, 10),
        endDate: DateTime(2025, 8, 20),
        totalDays: 11,
        reason: 'Fever and need medical rest for recovery. Doctor advised complete bed rest.',
        supportingDocuments: ['medical_certificate.pdf', 'doctor_prescription.jpg'],
        createdAt: DateTime(2025, 7, 17, 5, 58, 22),
        updatedAt: DateTime(2025, 7, 17, 5, 58, 22),
        userName: 'Priya Singh',
        userRole: 'Asst. Professor',
        userDepartment: 'Chemistry',
      ),
      AdminLeaveApplicationModel(
        id: 5,
        userId: 6,
        leaveType: 'sick',
        status: 'pending',
        startDate: DateTime(2025, 7, 22),
        endDate: DateTime(2025, 7, 23),
        totalDays: 2,
        reason: 'txxfxrccfcffx',
        supportingDocuments: ['Screenshot_20250716_131126.jpg'],
        createdAt: DateTime(2025, 7, 17, 5, 52, 38),
        updatedAt: DateTime(2025, 7, 17, 5, 52, 38),
        userName: 'Rajesh Mehta',
        userRole: 'Department Head',
        userDepartment: 'Administration',
      ),
      AdminLeaveApplicationModel(
        id: 4,
        userId: 6,
        leaveType: 'sick',
        status: 'pending',
        startDate: DateTime(2025, 8, 9),
        endDate: DateTime(2025, 8, 9),
        totalDays: 1,
        reason: 'Fever and need medical rest for recovery. Doctor advised complete bed rest.',
        supportingDocuments: ['medical_certificate.pdf', 'doctor_prescription.jpg'],
        createdAt: DateTime(2025, 7, 16, 16, 36, 29),
        updatedAt: DateTime(2025, 7, 16, 16, 36, 29),
        userName: 'Sunil Verma',
        userRole: 'System Administrator',
        userDepartment: 'IT Support',
      ),
    ];
  }
}