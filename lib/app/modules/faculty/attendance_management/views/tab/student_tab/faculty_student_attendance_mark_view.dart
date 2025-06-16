// lib/app/modules/faculty/attendance_management/views/faculty_student_attendance_mark_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../controllers/faculty_student_attendance_controller.dart';
import '../../../models/student_attendance_model.dart';

class FacultyStudentAttendanceMarkView extends StatelessWidget {
  FacultyStudentAttendanceMarkView({super.key});

  final FacultyStudentAttendanceController controller = Get.find<FacultyStudentAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle "Today" / "Another Date"
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildDateSelectionTab(
                    label: 'Today',
                    isSelected: controller.markAttendanceDate.value.isSameDay(DateTime.now()),
                    onTap: () => controller.selectMarkAttendanceDate(DateTime.now()),
                  ),
                ),
                Expanded(
                  child: _buildDateSelectionTab(
                    label: 'Another Date',
                    isSelected: !controller.markAttendanceDate.value.isSameDay(DateTime.now()),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: controller.markAttendanceDate.value,
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        controller.selectMarkAttendanceDate(pickedDate);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Marking Attendance for Date
          Text(
            'Marking attendance for',
            style: TextStyle(fontSize: 12, color: AppColors.greyText),
          ),
          Text(
            '${DateFormat('EEEE, MMM dd, yyyy').format(controller.markAttendanceDate.value)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 16),

          // Filters: Course, Section, Subject, Sub-Subject
          _buildDropdownTile(
            label: 'Course',
            value: controller.selectedCourse.value,
            items: controller.courses,
            onChanged: controller.selectCourse,
          ),
          _buildDropdownTile(
            label: 'Section',
            value: controller.selectedSection.value,
            items: controller.sections,
            onChanged: controller.selectSection,
          ),
          _buildDropdownTile(
            label: 'Subject',
            value: controller.selectedSubject.value,
            items: controller.subjects,
            onChanged: controller.selectSubject,
          ),
          _buildDropdownTile(
            label: 'Sub-Subject',
            value: controller.selectedSubSubject.value,
            items: controller.subSubjects,
            onChanged: controller.selectSubSubject,
            hintText: 'Select Sub-Subject (Optional)',
          ),
          const SizedBox(height: 16),

          // Show previous attendance toggle
          Obx(() => Row(
                children: [
                  Switch(
                    value: controller.showPreviousAttendance.value,
                    onChanged: controller.toggleShowPreviousAttendance,
                    activeColor: AppColors.primaryBlue,
                  ),
                  Text(
                    'Show previous attendance',
                    style: TextStyle(fontSize: 13, color: AppColors.darkText),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      print('View History tapped');
                      // Navigate to attendance history for this class/subject
                    },
                    child: Text('View History', style: TextStyle(color: AppColors.primaryBlue)),
                  ),
                ],
              )),
          const SizedBox(height: 16),

          // Search by name or roll number & Filter
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name or roll no...',
                    prefixIcon: Icon(Icons.search, color: AppColors.greyText),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                  onChanged: (value) {
                    // Implement search filtering
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {
                  print('Filter tapped');
                },
                icon: const Icon(Icons.filter_list, color: Colors.white, size: 18),
                label: const Text('Filter', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Student List for Marking
          Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Header Row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text('Roll No', style: _headerTextStyle())),
                        Expanded(flex: 3, child: Text('Student Name', style: _headerTextStyle())),
                        Expanded(flex: 4, child: Text('MARK PRESENT / ABSENT / LATE', style: _headerTextStyle(), textAlign: TextAlign.center)),
                      ],
                    ),
                  ),
                  const Divider(height: 1, thickness: 0.5),
                  Obx(() {
                    if (controller.studentsForMarking.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('No students found for this selection.'),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.studentsForMarking.length,
                      itemBuilder: (context, index) {
                        final student = controller.studentsForMarking[index];
                        return _buildStudentAttendanceRow(student, controller);
                      },
                    );
                  }),
                  const Divider(height: 1, thickness: 0.5),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Obx(() {
                      final presentCount = controller.studentsForMarking.where((s) => s.status.value == 'Present').length;
                      final absentCount = controller.studentsForMarking.where((s) => s.status.value == 'Absent').length;
                      final lateCount = controller.studentsForMarking.where((s) => s.status.value == 'Late').length;
                      final unmarkedCount = controller.studentsForMarking.where((s) => s.status.value == 'Unmarked').length;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: ${controller.studentsForMarking.length} Students',
                            style: TextStyle(fontSize: 12, color: AppColors.darkText),
                          ),
                          Row(
                            children: [
                              _buildStatusCount(presentCount, 'Present', AppColors.primaryGreen),
                              const SizedBox(width: 8),
                              _buildStatusCount(absentCount, 'Absent', AppColors.primaryRed),
                              const SizedBox(width: 8),
                              _buildStatusCount(lateCount, 'Late', AppColors.primaryOrange),
                              const SizedBox(width: 8),
                              _buildStatusCount(unmarkedCount, 'Unmarked', AppColors.greyText),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.submitMarkedAttendance,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Submit Attendance', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelectionTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cardBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.darkText : AppColors.greyText,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownTile({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: AppColors.cardBackground,
            ),
            child: DropdownButtonHideUnderline(
              child: Obx(() => DropdownButton<String>(
                    isExpanded: true,
                    value: value.isEmpty ? null : value,
                    hint: Text(hintText ?? 'Select $label', style: TextStyle(color: AppColors.greyText)),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(color: AppColors.darkText)),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _headerTextStyle() {
    return TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.greyText);
  }

  Widget _buildStudentAttendanceRow(StudentAttendanceMark student, FacultyStudentAttendanceController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(student.rollNo, style: TextStyle(fontSize: 13, color: AppColors.darkText)),
          ),
          Expanded(
            flex: 3,
            child: Text(student.name, style: TextStyle(fontSize: 13, color: AppColors.darkText)),
          ),
          Expanded(
            flex: 4,
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatusButton(
                        Icons.check, 'Present', student, controller, AppColors.primaryGreen),
                    _buildStatusButton(
                        Icons.close, 'Absent', student, controller, AppColors.primaryRed),
                    _buildStatusButton(
                        Icons.access_time_filled, 'Late', student, controller, AppColors.primaryOrange),
                    // If you have a 'Leave' status for marking, add it here
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(IconData icon, String status, StudentAttendanceMark student, FacultyStudentAttendanceController controller, Color color) {
    bool isSelected = student.status.value == status;
    return GestureDetector(
      onTap: () => controller.updateStudentMarkStatus(student.id, status),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 16,
          color: isSelected ? Colors.white : AppColors.greyText,
        ),
      ),
    );
  }

  Widget _buildStatusCount(int count, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          '$count $label',
          style: TextStyle(fontSize: 10, color: AppColors.greyText),
        ),
      ],
    );
  }
}

// Extension to compare dates without time
extension DateOnlyCompare on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}