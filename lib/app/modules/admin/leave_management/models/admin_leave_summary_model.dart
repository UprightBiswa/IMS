// -----------------------------------------------------------------------------
// Models (lib/app/modules/admin/leave_management/models/admin_leave_summary_model.dart)
// -----------------------------------------------------------------------------
class AdminLeaveSummaryModel {
  final int totalRequests;
  final int pending;
  final int approved;
  final int rejected;

  AdminLeaveSummaryModel({
    required this.totalRequests,
    required this.pending,
    required this.approved,
    required this.rejected,
  });

  factory AdminLeaveSummaryModel.fromJson(Map<String, dynamic> json) {
    return AdminLeaveSummaryModel(
      totalRequests: json['total_requests'] as int,
      pending: json['pending'] as int,
      approved: json['approved'] as int,
      rejected: json['rejected'] as int,
    );
  }

  // Dummy data for initial display
  static AdminLeaveSummaryModel dummy() {
    return AdminLeaveSummaryModel(
      totalRequests: 132,
      pending: 8,
      approved: 96,
      rejected: 14,
    );
  }
}