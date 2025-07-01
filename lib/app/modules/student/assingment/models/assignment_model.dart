// lib/app/modules/assignments/models/assignment_model.dart

enum AssignmentStatus {
  pending,
  dueSoon, // Added for clarity
  submitted,
  graded,
  overdue,
}

class Assignment {
  final String id;
  final String title;
  final String subject;
  final String professor;
  final DateTime dueDate;
  final String description;
  final List<String> attachedFiles;
  final AssignmentStatus status;
  final double? grade; // Nullable, if not yet graded
  final String? feedback; // Nullable, if not yet graded

  Assignment({
    required this.id,
    required this.title,
    required this.subject,
    required this.professor,
    required this.dueDate,
    this.description = '',
    this.attachedFiles = const [],
    this.status = AssignmentStatus.pending,
    this.grade,
    this.feedback,
  });

  // Dummy data generator for a list of assignments
  static List<Assignment> dummyList() {
    final now = DateTime.now();
    return [
      Assignment(
        id: 'A001',
        title: 'Algorithms Homework 1',
        subject: 'Computer Science',
        professor: 'Dr. Smith',
        dueDate: now.add(const Duration(days: 3)),
        description: 'Implement QuickSort and MergeSort algorithms.',
        status: AssignmentStatus.dueSoon,
      ),
      Assignment(
        id: 'A002',
        title: 'Physics Lab Report',
        subject: 'Physics',
        professor: 'Prof. Johnson',
        dueDate: now.subtract(const Duration(days: 2)),
        description: 'Experiment on projectile motion.',
        attachedFiles: ['lab_report_physics.pdf'],
        status: AssignmentStatus.overdue,
      ),
      Assignment(
        id: 'A003',
        title: 'Mathematics Problem Set 3',
        subject: 'Mathematics',
        professor: 'Dr. Lee',
        dueDate: now.add(const Duration(days: 10)),
        description: 'Solve problems on differential equations.',
        status: AssignmentStatus.pending,
      ),
      Assignment(
        id: 'A004',
        title: 'English Essay: "Climate Change"',
        subject: 'English',
        professor: 'Ms. Davis',
        dueDate: now.subtract(const Duration(days: 7)),
        description: 'Write a 1500-word essay on the impacts of climate change.',
        attachedFiles: ['essay_climate.docx'],
        status: AssignmentStatus.submitted,
        grade: 85.0,
        feedback: 'Well-researched, but improve citation style.',
      ),
      Assignment(
        id: 'A005',
        title: 'Operating Systems Project',
        subject: 'Computer Science',
        professor: 'Dr. Smith',
        dueDate: now.add(const Duration(days: 25)),
        description: 'Design and implement a basic process scheduler.',
        status: AssignmentStatus.pending,
      ),
      Assignment(
        id: 'A006',
        title: 'Chemistry Pre-Lab Quiz',
        subject: 'Chemistry',
        professor: 'Dr. Gupta',
        dueDate: now.add(const Duration(days: 1)),
        description: 'Short quiz on acid-base titrations.',
        status: AssignmentStatus.dueSoon,
      ),
      Assignment(
        id: 'A007',
        title: 'Data Structures Midterm Review',
        subject: 'Computer Science',
        professor: 'Dr. Smith',
        dueDate: now.add(const Duration(days: 5)),
        description: 'Review session for upcoming midterm exam.',
        status: AssignmentStatus.dueSoon,
      ),
      Assignment(
        id: 'A008',
        title: 'History Presentation',
        subject: 'History',
        professor: 'Dr. White',
        dueDate: now.subtract(const Duration(days: 15)),
        description: 'Present on World War II impacts.',
        attachedFiles: ['history_presentation.pptx'],
        status: AssignmentStatus.submitted,
        grade: 92.0,
        feedback: 'Excellent presentation skills and content.',
      ),
    ];
  }
}