// lib/app/modules/assignments/models/assignment_summary_model.dart
// (Content as provided in previous response, ensuring it imports assignment_model.dart if needed)
import 'package:flutter/material.dart';

class AssignmentSummaryModel {
  final int totalAssignments;
  final int completedAssignments;
  final int pendingAssignments;
  final double completionPercentage;
  final List<String> recommendedActions;
  final List<SubjectAssignmentBreakdown> subjectBreakdowns;
  final List<int> assignmentTimelineData; // 0: No assignment, 1: Completed, 2: Pending/Missed

  AssignmentSummaryModel({
    required this.totalAssignments,
    required this.completedAssignments,
    required this.pendingAssignments,
    required this.completionPercentage,
    required this.recommendedActions,
    required this.subjectBreakdowns,
    required this.assignmentTimelineData,
  });

  // Dummy data generator
  static AssignmentSummaryModel dummy() {
    return AssignmentSummaryModel(
      totalAssignments: 25,
      completedAssignments: 18,
      pendingAssignments: 7,
      completionPercentage: 72.0,
      recommendedActions: [
        "Complete 'Data Structures' homework by Friday",
        "Review 'Algorithm Design' project requirements",
        "Submit 'Operating Systems' lab report (overdue)"
      ],
      subjectBreakdowns: [
        SubjectAssignmentBreakdown(
          subject: 'Mathematics',
          total: 5,
          completed: 5,
          pending: 0,
          percentage: 100,
          status: 'Excellent',
          barColor: Colors.green,
        ),
        SubjectAssignmentBreakdown(
          subject: 'Computer Science',
          total: 8,
          completed: 6,
          pending: 2,
          percentage: 75,
          status: 'Good',
          barColor: Colors.blue,
        ),
        SubjectAssignmentBreakdown(
          subject: 'Physics',
          total: 6,
          completed: 4,
          pending: 2,
          percentage: 66,
          status: 'Warning',
          barColor: Colors.orange,
        ),
        SubjectAssignmentBreakdown(
          subject: 'English',
          total: 6,
          completed: 3,
          pending: 3,
          percentage: 50,
          status: 'Critical',
          barColor: Colors.red,
        ),
      ],
      assignmentTimelineData: [
        1, 1, 0, 2, 1, // Day 1-5
        -1, -1, // Weekend - represented by -1, not used in actual bars, just for data length
        1, 2, 1, 1, 0, // Day 8-12
        -1, -1, // Weekend
        1, 1, 2, // Day 15-17
      ],
    );
  }
}

class SubjectAssignmentBreakdown {
  final String subject;
  final int total;
  final int completed;
  final int pending;
  final int percentage;
  final String status;
  final Color barColor;

  SubjectAssignmentBreakdown({
    required this.subject,
    required this.total,
    required this.completed,
    required this.pending,
    required this.percentage,
    required this.status,
    required this.barColor,
  });
}