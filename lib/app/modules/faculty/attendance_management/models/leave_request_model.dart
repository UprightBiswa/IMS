import 'package:flutter/material.dart';

enum LeaveStatus { Approved, Rejected, Pending, Cancelled }

class LeaveRequest {
  final String id;
  final DateTime startDate;
  final DateTime endDate;
  final String leaveType; // e.g., "Medical emergency", "Personal reasons"
  final String reason;
  final DateTime submittedDate;
  final LeaveStatus status;
  final String? documentUrl; // Optional: URL to supporting document

  LeaveRequest({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.leaveType,
    required this.reason,
    required this.submittedDate,
    required this.status,
    this.documentUrl,
  });

  // Helper to get status string for UI
  String get statusString {
    switch (status) {
      case LeaveStatus.Approved:
        return 'Approved';
      case LeaveStatus.Rejected:
        return 'Rejected';
      case LeaveStatus.Pending:
        return 'Pending';
      case LeaveStatus.Cancelled:
        return 'Cancelled';
    }
  }

  // Helper to get status color for UI
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

  // Dummy data factories
  static List<LeaveRequest> dummyLeaveHistory() {
    return [
      LeaveRequest(
        id: 'L001',
        startDate: DateTime(2025, 4, 10),
        endDate: DateTime(2025, 4, 12),
        leaveType: 'Medical emergency',
        reason: 'Acute fever',
        submittedDate: DateTime(2025, 4, 8),
        status: LeaveStatus.Approved,
      ),
      LeaveRequest(
        id: 'L002',
        startDate: DateTime(2025, 3, 20),
        endDate: DateTime(2025, 3, 20),
        leaveType: 'Personal reasons',
        reason: 'Family event',
        submittedDate: DateTime(2025, 3, 18),
        status: LeaveStatus.Rejected,
      ),
      LeaveRequest(
        id: 'L003',
        startDate: DateTime(2025, 2, 1),
        endDate: DateTime(2025, 2, 2),
        leaveType: 'Sick Leave',
        reason: 'Flu symptoms',
        submittedDate: DateTime(2025, 1, 30),
        status: LeaveStatus.Approved,
      ),
    ];
  }
}

class LeaveBalance {
  final String type;
  final int total;
  final int consumed;
  final int remaining;

  LeaveBalance({
    required this.type,
    required this.total,
    required this.consumed,
    required this.remaining,
  });

  static List<LeaveBalance> dummyBalances() {
    return [
      LeaveBalance(type: 'Sick Leave', total: 7, consumed: 5, remaining: 2),
      LeaveBalance(type: 'Casual Leave', total: 7, consumed: 4, remaining: 3),
      LeaveBalance(type: 'Earned Leave', total: 18, consumed: 10, remaining: 8),
    ];
  }
}
