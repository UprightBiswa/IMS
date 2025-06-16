import 'package:flutter/material.dart';

class SubjectWiseAttendanceCardList extends StatelessWidget {
  const SubjectWiseAttendanceCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      SubjectAttendance(
        subject: 'Mathematics',
        percentage: 95,
        teacher: 'Dr. John Smith',
        status: 'Good',
        attended: 38,
        total: 40,
        barColor: Colors.green,
      ),
      SubjectAttendance(
        subject: 'Chemistry',
        percentage: 94,
        teacher: 'Dr. Michael Brown',
        status: 'Good',
        attended: 30,
        total: 32,
        barColor: Colors.green,
      ),
      SubjectAttendance(
        subject: 'Computer Science',
        percentage: 93,
        teacher: 'Prof. Sarah Johnson',
        status: 'Good',
        attended: 28,
        total: 30,
        barColor: Colors.green,
      ),
      SubjectAttendance(
        subject: 'English',
        percentage: 80,
        teacher: 'Ms. Emily Davis',
        status: 'Warning',
        attended: 20,
        total: 25,
        barColor: Colors.orange,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            "Subject-wise Attendance",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFEFEFE),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Color(0xFFE2E2E3)),
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: subjects.length,
            itemBuilder: (context, index) =>
                SubjectAttendanceCard(subject: subjects[index]),
          ),
        ),
      ],
    );
  }
}

class SubjectAttendanceCard extends StatelessWidget {
  final SubjectAttendance subject;

  const SubjectAttendanceCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final attendanceRatio = subject.attended / subject.total;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Subject Name and %
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject.subject,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Text(
                "${subject.percentage}%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 4),

          /// Faculty and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject.teacher,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                subject.status,
                style: TextStyle(
                  fontSize: 12,
                  color: subject.status == 'Warning'
                      ? Colors.orange
                      : Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Total / Attended
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Total",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "${subject.total}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Attended",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "${subject.attended}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          /// Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: attendanceRatio,
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation<Color>(subject.barColor),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class SubjectAttendance {
  final String subject;
  final int percentage;
  final String teacher;
  final String status;
  final int attended;
  final int total;
  final Color barColor;

  SubjectAttendance({
    required this.subject,
    required this.percentage,
    required this.teacher,
    required this.status,
    required this.attended,
    required this.total,
    required this.barColor,
  });
}
