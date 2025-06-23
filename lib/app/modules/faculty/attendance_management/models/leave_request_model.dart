import 'package:flutter/material.dart';

enum LeaveStatus { Approved, Rejected, Pending, Cancelled }

class LeaveRequest {
  final int days;
  final String leaveDates;
  final String leaveType;
  final String reason;
  final LeaveStatus status;

  LeaveRequest({
    required this.days,
    required this.leaveDates,
    required this.leaveType,
    required this.reason,
    required this.status,
  });

  factory LeaveRequest.fromJson(Map<String, dynamic> json) {
    return LeaveRequest(
      days: json['days'],
      leaveDates: json['leave_dates'],
      leaveType: json['leave_type'],
      reason: json['reason'],
      status: _parseStatus(json['status']),
    );
  }

  static LeaveStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return LeaveStatus.Approved;
      case 'rejected':
        return LeaveStatus.Rejected;
      case 'pending':
        return LeaveStatus.Pending;
      case 'cancelled':
        return LeaveStatus.Cancelled;
      default:
        return LeaveStatus.Pending;
    }
  }

  String get statusString => status.name;

  Color get statusColor {
    switch (status) {
      case LeaveStatus.Approved:
        return Colors.green;
      case LeaveStatus.Rejected:
        return Colors.red;
      case LeaveStatus.Pending:
        return Colors.orange;
      case LeaveStatus.Cancelled:
        return Colors.grey;
    }
  }
}
