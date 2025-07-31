// student_enrollment_management/views/student_registration_dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../controllers/student_registration_controller.dart';
import '../models/student_model_list.dart';

class StudentRegistrationDashboardView extends StatelessWidget {
  const StudentRegistrationDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentRegistrationController());

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Add New Student',
        showDrawerIcon: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Onboard Students',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(Routes.ADMIN_ADD_NEW_STUDENT);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Student'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _StatCard(
                    title: 'Total Student Added',
                    count: 120,
                    subText: 'Across 6 departments',
                  ),
                  const SizedBox(width: 16),
                  _StatCard(
                    title: 'Total Faculty Added',
                    count: 32,
                    subText: 'Across 6 departments',
                    isGreen: true,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _SectionTitle('Recent Student Added'),
              _RecentStudentTable(controller.recentStudents),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("View All"),
                ),
              ),
              const SizedBox(height: 16),
              _SectionTitle('ID Generated List'),
              _IdGeneratedTable(controller.idGeneratedList),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("View All"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final String subText;
  final bool isGreen;

  const _StatCard({
    required this.title,
    required this.count,
    required this.subText,
    this.isGreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isGreen ? Colors.green[50] : Colors.blue[50],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(subText, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

class _RecentStudentTable extends StatelessWidget {
  final List<StudentModelList> students;

  const _RecentStudentTable(this.students);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
      },
      children: [
        const TableRow(
          children: [
            Text('STUDENT NAME', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('DEPARTMENT', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'ID GENERATED STATUS',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ...students.map(
          (s) => TableRow(
            children: [
              Text(s.name),
              Text(s.department),
              Text(s.status, style: TextStyle(color: s.statusColor)),
            ],
          ),
        ),
      ],
    );
  }
}

class _IdGeneratedTable extends StatelessWidget {
  final List<StudentModelList> students;

  const _IdGeneratedTable(this.students);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1.5),
      },
      children: [
        const TableRow(
          children: [
            Text('STUDENT NAME', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('STUDENT ID', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('PASSWORD', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        ...students.map(
          (s) => TableRow(
            children: [
              Text(s.name),
              Text(s.studentId ?? '-'),
              Text(s.password ?? '-'),
            ],
          ),
        ),
      ],
    );
  }
}
