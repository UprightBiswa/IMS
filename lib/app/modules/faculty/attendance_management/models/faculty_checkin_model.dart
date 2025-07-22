// NEW Model: lib/app/modules/faculty/attendance_management/models/faculty_checkin_model.dart
class FacultyCheckInStatus {
  final bool isCheckedIn;
  final DateTime? lastCheckInTime;
  final DateTime? lastCheckOutTime;
  final String? checkInMessage; // e.g., "You are currently checked in"

  FacultyCheckInStatus({
    required this.isCheckedIn,
    this.lastCheckInTime,
    this.lastCheckOutTime,
    this.checkInMessage,
  });

  factory FacultyCheckInStatus.fromJson(Map<String, dynamic> json) {
    return FacultyCheckInStatus(
      isCheckedIn: json['is_checked_in'] as bool,
      lastCheckInTime: json['last_check_in_time'] != null
          ? DateTime.parse(json['last_check_in_time'])
          : null,
      lastCheckOutTime: json['last_check_out_time'] != null
          ? DateTime.parse(json['last_check_out_time'])
          : null,
      checkInMessage: json['check_in_message'] as String?,
    );
  }

  static FacultyCheckInStatus dummyCheckedIn() {
    return FacultyCheckInStatus(
      isCheckedIn: true,
      lastCheckInTime: DateTime.now().subtract(const Duration(hours: 3)),
      checkInMessage: 'You are currently checked in.',
    );
  }

  static FacultyCheckInStatus dummyCheckedOut() {
    return FacultyCheckInStatus(
      isCheckedIn: false,
      lastCheckInTime: DateTime.now().subtract(const Duration(hours: 8)),
      lastCheckOutTime: DateTime.now().subtract(const Duration(hours: 1)),
      checkInMessage: 'You are currently checked out.',
    );
  }
}