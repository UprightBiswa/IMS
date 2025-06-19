class StaffOverviewModel {
  final String staffName;
  final String department;
  final String designation;
  final int compliancePercentage;
  final String status;

  StaffOverviewModel({
    required this.staffName,
    required this.department,
    required this.designation,
    required this.compliancePercentage,
    required this.status,
  });

  factory StaffOverviewModel.fromJson(Map<String, dynamic> json) => StaffOverviewModel(
        staffName: json['staff_name'],
        department: json['department'],
        designation: json['designation'],
        compliancePercentage: json['compliance_percentage'],
        status: json['status'],
      );
}
