// lib/app/modules/syllabus/models/syllabus_models.dart
import 'package:flutter/material.dart'; // For IconData

// --- Syllabus Overview Models ---
class SubjectProgress {
  final String subjectName;
  final String instructorName;
  final int completedChapters;
  final int totalChapters;
  final SubjectStatus status;

  SubjectProgress({
    required this.subjectName,
    required this.instructorName,
    required this.completedChapters,
    required this.totalChapters,
    required this.status,
  });

  // Helper to get percentage
  double get progressPercentage => totalChapters > 0 ? (completedChapters / totalChapters) : 0.0;

  static List<SubjectProgress> dummyList() {
    return [
      SubjectProgress(
        subjectName: 'Data Structures',
        instructorName: 'Dr. Priya Sharma',
        completedChapters: 19,
        totalChapters: 20,
        status: SubjectStatus.good, // Renamed from Excellent to Good for consistency with image
      ),
      SubjectProgress(
        subjectName: 'Database Management',
        instructorName: 'Prof. Rajesh Kumar',
        completedChapters: 14,
        totalChapters: 16,
        status: SubjectStatus.good,
      ),
      SubjectProgress(
        subjectName: 'Computer Networks',
        instructorName: 'Dr. Sunita Patel',
        completedChapters: 6,
        totalChapters: 12,
        status: SubjectStatus.inProgress,
      ),
      SubjectProgress(
        subjectName: 'English Literature',
        instructorName: 'Ms. Emily Davis',
        completedChapters: 5,
        totalChapters: 14,
        status: SubjectStatus.behind,
      ),
    ];
  }
}

enum SubjectStatus {
  good,
  inProgress,
  behind,
}

// Model for the progress summary (bottom part of Syllabus Overview)
class OverallProgressSummary {
  final double overallPercentage;
  final int subjectsCompleted;
  final int totalSubjects;
  final int chaptersCompleted;
  final int totalChapters;
  final String estimatedTime;

  OverallProgressSummary({
    required this.overallPercentage,
    required this.subjectsCompleted,
    required this.totalSubjects,
    required this.chaptersCompleted,
    required this.totalChapters,
    required this.estimatedTime,
  });

  static OverallProgressSummary dummy() {
    return OverallProgressSummary(
      overallPercentage: 72,
      subjectsCompleted: 9,
      totalSubjects: 12, // Dummy total, adjust as needed
      chaptersCompleted: 44,
      totalChapters: 60, // Dummy total, adjust as needed
      estimatedTime: '2 weeks',
    );
  }
}

class DailyProgress {
  final DateTime date;
  final double progressValue; // 0.0 to 1.0 or 0 to 100

  DailyProgress({required this.date, required this.progressValue});

  static List<DailyProgress> dummyList() {
    return List.generate(17, (index) {
      final date = DateTime(2025, 5, 1).add(Duration(days: index));
      double progress = (index % 5 == 0) ? 0.8 : (index % 3 == 0 ? 0.6 : 0.4);
      if (index == 0) progress = 0.9; // Example for specific day
      if (index == 16) progress = 0.7; // Example for specific day
      return DailyProgress(date: date, progressValue: progress);
    });
  }
}


// --- Exam Schedule Models ---
class Exam {
  final String title;
  final String instructor;
  final DateTime dateTime;
  final String location;
  final String duration; // e.g., "3 hours"
  final ExamStatus status; // Today, Upcoming, Completed

  Exam({
    required this.title,
    required this.instructor,
    required this.dateTime,
    required this.location,
    required this.duration,
    required this.status,
  });

  static List<Exam> dummyList() {
    final now = DateTime.now();
    return [
      // Today's Exam
      Exam(
        title: 'English Literature',
        instructor: 'Ms. Emily Davis',
        dateTime: DateTime(now.year, now.month, now.day, 10, 0), // Today 10:00 AM
        location: 'Room A-101',
        duration: '3 hours',
        status: ExamStatus.today,
      ),
      // Upcoming Exams
      Exam(
        title: 'Computer Networks',
        instructor: 'Dr. Anita Patel',
        dateTime: DateTime(now.year, now.month, now.day).add(const Duration(days: 3, hours: 14)), // 3 days from now
        location: 'Room B-205',
        duration: '3 hours',
        status: ExamStatus.upcoming,
      ),
      Exam(
        title: 'Database Management',
        instructor: 'Prof. Rajesh Kumar',
        dateTime: DateTime(now.year, now.month, now.day).add(const Duration(days: 5, hours: 15)), // 5 days from now
        location: 'Room C-301',
        duration: '3 hours',
        status: ExamStatus.upcoming,
      ),
      Exam(
        title: 'Software Engineering',
        instructor: 'Dr. Sarah Wilson',
        dateTime: DateTime(now.year, now.month, now.day).add(const Duration(days: 7, hours: 10)), // 1 week from now
        location: 'Room A-102',
        duration: '3 hours',
        status: ExamStatus.upcoming,
      ),
      // Completed Exams (from the past)
      Exam(
        title: 'Data Structures',
        instructor: 'Dr. Priya Sharma',
        dateTime: DateTime(now.year, now.month, now.day - 7, 9, 0), // 7 days ago
        location: 'Room B-201',
        duration: '3 hours',
        status: ExamStatus.completed,
      ),
      Exam(
        title: 'Operating Systems',
        instructor: 'Dr. Michael Chen',
        dateTime: DateTime(now.year, now.month, now.day - 15, 10, 0), // 15 days ago
        location: 'Room A-105',
        duration: '3 hours',
        status: ExamStatus.completed,
      ),
    ];
  }
}

enum ExamStatus {
  today,
  upcoming,
  completed,
}

// --- Study Resources Models ---
class ResourceSummary {
  final int totalBooks;
  final int totalNotes;
  final int totalVideos;
  final int totalPractice;

  ResourceSummary({
    required this.totalBooks,
    required this.totalNotes,
    required this.totalVideos,
    required this.totalPractice,
  });

  static ResourceSummary dummy() {
    return ResourceSummary(
      totalBooks: 9,
      totalNotes: 4,
      totalVideos: 12,
      totalPractice: 6,
    );
  }
}

class RecentlyAccessedResource {
  final String title;
  final String timeAgo;
  final IconData icon; // E.g., Icons.book, Icons.description, Icons.play_circle
  final String type; // e.g., 'Book', 'Notes', 'Video'

  RecentlyAccessedResource({
    required this.title,
    required this.timeAgo,
    required this.icon,
    required this.type,
  });

  static List<RecentlyAccessedResource> dummyList() {
    return [
      RecentlyAccessedResource(
        title: 'Algorithm Design Manual',
        timeAgo: '2 hours ago',
        icon: Icons.book_outlined,
        type: 'Book',
      ),
      RecentlyAccessedResource(
        title: 'Database Normalization Notes',
        timeAgo: '7 hours ago',
        icon: Icons.description_outlined,
        type: 'Notes',
      ),
      RecentlyAccessedResource(
        title: 'TCP/IP Protocol Explained',
        timeAgo: '1 day ago',
        icon: Icons.play_circle_outline,
        type: 'Video',
      ),
    ];
  }
}

class RecommendedResource {
  final String title;
  final String author;
  final String description;
  final String pagesOrDuration; // e.g., '600 pages', '2 hours'
  final String status; // e.g., 'Downloaded', 'Synced'
  final IconData icon; // E.g., Icons.book, Icons.play_circle_filled

  RecommendedResource({
    required this.title,
    required this.author,
    required this.description,
    required this.pagesOrDuration,
    required this.status,
    required this.icon,
  });

  static List<RecommendedResource> dummyList() {
    return [
      RecommendedResource(
        title: 'Introduction to Algorithms (Cormen)',
        author: 'by Thomas H. Cormen • Data Structures',
        description: 'Fundamental algorithms and data structures.',
        pagesOrDuration: '1200 pages',
        status: 'Downloaded',
        icon: Icons.book_outlined,
      ),
      RecommendedResource(
        title: 'Computer Networks: A Top-Down Approach',
        author: 'by James F. Kurose • Computer Networks',
        description: 'Modern approach to computer networking.',
        pagesOrDuration: '700 pages',
        status: 'Synced',
        icon: Icons.book_outlined,
      ),
    ];
  }
}

class StudyNote {
  final String title;
  final String authorCourse; // e.g., 'Dr. Priya Sharma • Data Structures'
  final String description;
  final String pagesOrDuration; // e.g., '12 pages', '30 min'
  final String status; // e.g., 'Synced', 'Downloaded'
  final IconData icon; // E.g., Icons.description

  StudyNote({
    required this.title,
    required this.authorCourse,
    required this.description,
    required this.pagesOrDuration,
    required this.status,
    required this.icon,
  });

  static List<StudyNote> dummyList() {
    return [
      StudyNote(
        title: 'Binary Search Trees - Complete',
        authorCourse: 'Created by Dr. Priya Sharma • Data Structures',
        description: 'Detailed notes on tree traversal, operations, and balancing.',
        pagesOrDuration: '12 pages',
        status: 'Synced',
        icon: Icons.description_outlined,
      ),
      StudyNote(
        title: 'Algorithms & Database Design',
        authorCourse: 'Student Notes • Database Management',
        description: 'Collaborative notes on database design principles.',
        pagesOrDuration: '8 pages',
        status: 'Practice', // Could be 'Practice' for notes related to practice
        icon: Icons.description_outlined,
      ),
    ];
  }
}

class VideoLecture {
  final String title;
  final String instructorCourse;
  final String description;
  final String duration;
  final String status; // e.g., 'Watched', 'In Progress'
  final IconData icon;

  VideoLecture({
    required this.title,
    required this.instructorCourse,
    required this.description,
    required this.duration,
    required this.status,
    required this.icon,
  });

  static List<VideoLecture> dummyList() {
    return [
      VideoLecture(
        title: 'Graph Algorithms Visualization',
        instructorCourse: 'By Dr. John Doe • Data Structures',
        description: 'Visual explanation of DFS, BFS, and shortest path algorithms.',
        duration: '45 min',
        status: 'Interactive', // Or 'Watched', 'In Progress'
        icon: Icons.play_circle_outline,
      ),
      VideoLecture(
        title: 'Network Security Fundamentals',
        instructorCourse: 'Dr. Anita Patel • Computer Networks',
        description: 'Introduction to network security threats and prevention.',
        duration: '38 min',
        status: 'Recorded',
        icon: Icons.play_circle_outline,
      ),
    ];
  }
}

class PracticeQuiz {
  final String title;
  final String subjectChapters;
  final String description;
  final String status; // e.g., 'New', 'Completed'
  final IconData icon;

  PracticeQuiz({
    required this.title,
    required this.subjectChapters,
    required this.description,
    required this.status,
    required this.icon,
  });

  static List<PracticeQuiz> dummyList() {
    return [
      PracticeQuiz(
        title: 'Data Structures Mock Test - 1',
        subjectChapters: 'Data Structures • Trees & Graph',
        description: 'Practice questions on tree and graph algorithms, stacks, and queues.',
        status: 'New',
        icon: Icons.assignment_outlined,
      ),
      PracticeQuiz(
        title: 'SQL Practice Problems',
        subjectChapters: 'Database Management • SQL Basics',
        description: 'Hands-on problems to practice SQL queries.',
        status: 'Practice',
        icon: Icons.code_outlined,
      ),
    ];
  }
}

class ExternalLink {
  final String title;
  final String description;
  final String urlSource;
  final String status; // e.g., 'Free', 'Premium'
  final IconData icon;

  ExternalLink({
    required this.title,
    required this.description,
    required this.urlSource,
    required this.status,
    required this.icon,
  });

  static List<ExternalLink> dummyList() {
    return [
      ExternalLink(
        title: 'Online Programming Practice',
        description: 'Competitive programming platform with a wide range of problems and solutions.',
        urlSource: 'Programiz',
        status: 'Free',
        icon: Icons.link_outlined,
      ),
      ExternalLink(
        title: 'GeeksforGeeks - CS Portal',
        description: 'Comprehensive computer science portal with articles, tutorials, and interview prep.',
        urlSource: 'GeeksforGeeks',
        status: 'Free',
        icon: Icons.link_outlined,
      ),
    ];
  }
}