// lib/app/modules/grades/models/grades_models.dart
import 'package:flutter/material.dart'; // For IconData

// --- Grades Overview Models ---
class OverallGradesSummary {
  final double currentGPA;
  final String academicYear;
  final String semester;
  final double overallPercentage; // For the 80% circle
  final String overallStatus; // "Good", "Excellent"
  final double semesterAvg;
  final double midTermAvg;
  final double internalsAvg;

  OverallGradesSummary({
    required this.currentGPA,
    required this.academicYear,
    required this.semester,
    required this.overallPercentage,
    required this.overallStatus,
    required this.semesterAvg,
    required this.midTermAvg,
    required this.internalsAvg,
  });

  static OverallGradesSummary dummy() {
    return OverallGradesSummary(
      currentGPA: 3.2,
      academicYear: '2024-25',
      semester: 'Semester 5',
      overallPercentage: 80,
      overallStatus: 'Good',
      semesterAvg: 85,
      midTermAvg: 89,
      internalsAvg: 78,
    );
  }
}

class SemesterCreditSummary {
  final int totalCredits;
  final int subjectsPassed;
  final int creditsEarned;
  final String classRank; // "12/45"

  SemesterCreditSummary({
    required this.totalCredits,
    required this.subjectsPassed,
    required this.creditsEarned,
    required this.classRank,
  });

  static SemesterCreditSummary dummy() {
    return SemesterCreditSummary(
      totalCredits: 24,
      subjectsPassed: 6,
      creditsEarned: 24,
      classRank: '12/45',
    );
  }
}

class SubjectPerformance {
  final String subjectName;
  final String instructorName;
  final String grade;
  final double percentage; // Score out of 100
  final String status; // Excellent, Good, Average, Critical

  final double midTermScore;
  final double assignmentsScore;
  final double attendancePercentage; // From grades.png

  SubjectPerformance({
    required this.subjectName,
    required this.instructorName,
    required this.grade,
    required this.percentage,
    required this.status,
    required this.midTermScore,
    required this.assignmentsScore,
    required this.attendancePercentage,
  });

  static List<SubjectPerformance> dummyList() {
    return [
      SubjectPerformance(
        subjectName: 'Mathematics',
        instructorName: 'Dr. John Smith',
        grade: 'A-',
        percentage: 95,
        status: 'Excellent',
        midTermScore: 92,
        assignmentsScore: 98,
        attendancePercentage: 96,
      ),
      SubjectPerformance(
        subjectName: 'Data Structures',
        instructorName: 'Dr. Priya Sharma',
        grade: 'B+',
        percentage: 88,
        status: 'Good',
        midTermScore: 85,
        assignmentsScore: 90,
        attendancePercentage: 92,
      ),
      SubjectPerformance(
        subjectName: 'Software Engineering',
        instructorName: 'Prof. Robert Chen',
        grade: 'B+',
        percentage: 87,
        status: 'Good',
        midTermScore: 90,
        assignmentsScore: 85,
        attendancePercentage: 89,
      ),
      SubjectPerformance(
        subjectName: 'Database Systems',
        instructorName: 'Dr. Amanda Wilson',
        grade: 'B',
        percentage: 84,
        status: 'Good',
        midTermScore: 82,
        assignmentsScore: 90,
        attendancePercentage: 88,
      ),
      SubjectPerformance(
        subjectName: 'Computer Networks',
        instructorName: 'Dr. Anita Patel',
        grade: 'C+',
        percentage: 72,
        status: 'Average',
        midTermScore: 70,
        assignmentsScore: 75,
        attendancePercentage: 68,
      ),
      SubjectPerformance(
        subjectName: 'English Literature',
        instructorName: 'Ms. Emily Davis',
        grade: 'D+',
        percentage: 65,
        status: 'Critical',
        midTermScore: 62,
        assignmentsScore: 68,
        attendancePercentage: 65,
      ),
    ];
  }
}

// For Performance Trends chart
class PerformanceTrend {
  final String subject;
  final double score; // 0-100

  PerformanceTrend({required this.subject, required this.score});

  static List<PerformanceTrend> dummyList() {
    return [
      PerformanceTrend(subject: 'Math', score: 90),
      PerformanceTrend(subject: 'Data Struct', score: 85),
      PerformanceTrend(subject: 'Algorithms', score: 88),
      PerformanceTrend(subject: 'Networks', score: 70),
      PerformanceTrend(subject: 'English', score: 65),
      PerformanceTrend(subject: 'Database', score: 82),
      PerformanceTrend(subject: 'Software', score: 87),
    ];
  }
}

// For Recommended Actions (similar to Syllabus, but repeated in Grades)
class AcademicRecommendation {
  final String text;

  AcademicRecommendation({required this.text});

  static List<AcademicRecommendation> dummyList() {
    return [
      AcademicRecommendation(text: 'Your progress forecast is indicating a downward trend.'),
      AcademicRecommendation(text: 'Focus on English Literature - improve by completing 2 assignments.'),
      AcademicRecommendation(text: 'Attend all Computer Networks classes this month (crucial for exam).'),
      AcademicRecommendation(text: 'Schedule meeting with academic advisor to discuss strategies.'),
      AcademicRecommendation(text: 'Consider joining study groups for subjects showing downward trends'),
    ];
  }
}


// --- Grades Exams Tab (similar to Syllabus Exam, but showing results) ---
enum GradeExamStatus {
  upcoming,
  finalExam, // "Final Exam" label
  midTerm, // "Mid-Term" label
}

class GradeExam {
  final String title;
  final String? instructor;
  final DateTime dateTime;
  final String? location;
  final String? timeRemaining; // e.g., "01 day", "03 days"
  final GradeExamStatus status;
  final String? score; // e.g., "84/100"
  final String? remarks; // e.g., "Good", "Excellent"

  GradeExam({
    required this.title,
    this.instructor,
    required this.dateTime,
    this.location,
    this.timeRemaining,
    required this.status,
    this.score,
    this.remarks,
  });

  static List<GradeExam> dummyUpcomingExams() {
    final now = DateTime.now();
    return [
      GradeExam(
        title: 'Mathematics',
        dateTime: DateTime(now.year, now.month, now.day + 2, 9, 0),
        location: 'Room C-105, Main Building',
        timeRemaining: '01 day', // Dynamic for real
        status: GradeExamStatus.finalExam, // In UI it says Final Exam
      ),
      GradeExam(
        title: 'Data Structures',
        dateTime: DateTime(now.year, now.month, now.day + 3, 14, 0),
        location: 'Room B-20A, CS Building',
        timeRemaining: '03 days',
        status: GradeExamStatus.finalExam,
      ),
      GradeExam(
        title: 'Computer Networks',
        dateTime: DateTime(now.year, now.month, now.day + 5, 10, 0),
        location: 'Room C-105, Engineering Block',
        timeRemaining: '05 days',
        status: GradeExamStatus.finalExam,
      ),
    ];
  }

  static List<GradeExam> dummyRecentResults() {
    return [
      GradeExam(
        title: 'Database Systems',
        dateTime: DateTime(2024, 5, 15), // Dummy past date
        status: GradeExamStatus.midTerm,
        score: '84/100',
        remarks: 'Good',
      ),
      GradeExam(
        title: 'Software Engineering',
        dateTime: DateTime(2024, 5, 10),
        status: GradeExamStatus.midTerm, // Assuming quiz is part of mid-term evaluation
        score: '29/30',
        remarks: 'Excellent',
      ),
      GradeExam(
        title: 'English Literature',
        dateTime: DateTime(2024, 5, 10),
        status: GradeExamStatus.midTerm, // Assuming essay test is part of mid-term evaluation
        score: '65/100',
        remarks: 'Average',
      ),
    ];
  }
}

// For Study Resources in Grades section
class GradeStudyResource {
  final String title;
  final String description;
  final IconData icon; // E.g., Icons.description, Icons.play_circle_filled
  final String type; // e.g., PDF, Video
  final String? lastUpdatedOrCount; // e.g., "Updated 3 days ago", "12 videos"

  GradeStudyResource({
    required this.title,
    required this.description,
    required this.icon,
    required this.type,
    this.lastUpdatedOrCount,
  });

  static List<GradeStudyResource> dummyList() {
    return [
      GradeStudyResource(
        title: 'Mathematics Formula Sheet',
        description: 'Updated 3 days ago',
        icon: Icons.description_outlined,
        type: 'PDF',
      ),
      GradeStudyResource(
        title: 'Data Structures Video Lectures',
        description: 'Video lectures on advanced data structures',
        icon: Icons.play_circle_outline,
        type: 'Video',
        lastUpdatedOrCount: '12 videos • 4 hours',
      ),
      GradeStudyResource(
        title: 'Computer Networks Notes',
        description: 'Comprehensive notes on network protocols',
        icon: Icons.description_outlined,
        type: 'Notes',
      ),
      GradeStudyResource(
        title: 'Previous Year Question Papers',
        description: '2019-2023 • All subjects',
        icon: Icons.assignment_outlined,
        type: 'Practice',
      ),
    ];
  }
}

// For Recent Exam Performance in Grades Results tab
class RecentExamPerformance {
  final String subject;
  final String examType;
  final String score;
  final String status; // Good, Excellent, Average, Critical

  RecentExamPerformance({
    required this.subject,
    required this.examType,
    required this.score,
    required this.status,
  });

  static List<RecentExamPerformance> dummyList() {
    return [
      RecentExamPerformance(subject: 'Mathematics', examType: 'Mid-Term', score: '92/100', status: 'Excellent'),
      RecentExamPerformance(subject: 'Data Structures', examType: 'Mid-Term', score: '85/100', status: 'Good'),
      RecentExamPerformance(subject: 'Computer Networks', examType: 'Quiz 2', score: '75/100', status: 'Average'),
      RecentExamPerformance(subject: 'English Literature', examType: 'Essay Test', score: '65/100', status: 'Critical'),
      RecentExamPerformance(subject: 'Database Systems', examType: 'Practical', score: '88/100', status: 'Good'),
      RecentExamPerformance(subject: 'Software Engineering', examType: 'Final Exam', score: '87/100', status: 'Good'),
    ];
  }
}