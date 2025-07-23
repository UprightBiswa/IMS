// -----------------------------------------------------------------------------
// Models (lib/app/modules/faculty/attendance_management/models/session_for_marking_model.dart) - UPDATED
// Renamed from TodaySessionModel to SessionForMarkingModel for clarity
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionForMarkingModel {
  final int sessionId; // Corresponds to API's session_id
  final String courseCode;
  final String courseTitle;
  final int durationMinutes;
  final int enrolledStudents;
  final String location; // Can be used for "Section" in UI context
  final String markingSessionUuid;
  final String markingStatus;
  final String sessionTime;
  final String sessionType;
  final String topic;

  SessionForMarkingModel({
    required this.sessionId,
    required this.courseCode,
    required this.courseTitle,
    required this.durationMinutes,
    required this.enrolledStudents,
    required this.location,
    required this.markingSessionUuid,
    required this.markingStatus,
    required this.sessionTime,
    required this.sessionType,
    required this.topic,
  });

  factory SessionForMarkingModel.fromJson(Map<String, dynamic> json) {
    return SessionForMarkingModel(
      sessionId: json['session_id'] as int,
      courseCode: json['course_code'] as String,
      courseTitle: json['course_title'] as String,
      durationMinutes: json['duration_minutes'] as int,
      enrolledStudents: json['enrolled_students'] as int,
      location: json['location'] as String,
      markingSessionUuid: json['marking_session_uuid'] as String,
      markingStatus: json['marking_status'] as String,
      sessionTime: json['session_time'] as String,
      sessionType: json['session_type'] as String,
      topic: json['topic'] as String,
    );
  }

  // Helper to get display string for Course dropdown
  String get displayCourse => courseTitle;

  // Helper to get display string for Section dropdown (using location)
  String get displaySection => location;

  // Helper to get display string for Subject dropdown (using topic)
  String get displaySubject => topic;

  // Helper to combine time for display
  String get displayTime {
    try {
      final timeParts = sessionTime.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final startTime = TimeOfDay(hour: hour, minute: minute);
      final endTime = TimeOfDay(
        hour: hour,
        minute: minute,
      ).plusMinutes(durationMinutes);

      final formatter = DateFormat.jm(); // For 12-hour format with AM/PM
      return '${formatter.format(DateTime(2000, 1, 1, startTime.hour, startTime.minute))} - ${formatter.format(DateTime(2000, 1, 1, endTime.hour, endTime.minute))}';
    } catch (e) {
      return sessionTime; // Fallback
    }
  }
  // New: Combined display string for the single session dropdown
  String get displayString => '$courseTitle - $location - $topic (${displayTime})';

}

extension on TimeOfDay {
  TimeOfDay plusMinutes(int minutes) {
    int newMinute = minute + minutes;
    int newHour = hour + (newMinute ~/ 60);
    newMinute %= 60;
    newHour %= 24;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }
}
