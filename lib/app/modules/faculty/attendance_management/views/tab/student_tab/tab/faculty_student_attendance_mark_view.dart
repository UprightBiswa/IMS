import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../../theme/app_colors.dart';
import '../../../../controllers/faculty_student_attendance_controller.dart';
import '../../../../models/session_for_marking_model.dart';
import '../../../../models/student_attendance_model.dart';
import '../../../../widgets/student_dashboard_upload_image.dart';

class FacultyStudentAttendanceMarkView extends StatelessWidget {
  FacultyStudentAttendanceMarkView({super.key});

  final FacultyStudentAttendanceController controller =
      Get.find<FacultyStudentAttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1.6,
          color: const Color(0xFF5F5D5D).withValues(alpha: .1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mark Attendance',
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                ),

                const SizedBox(height: 10),
                // Toggle "Today" / "Another Date"
                Container(
                  height: 40,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildDateSelectionTab(
                          icon: Icons.calendar_today,
                          label: 'Today',
                          isSelected: controller.markAttendanceDate.value
                              .isSameDay(DateTime.now()),
                          onTap: () => controller.selectMarkAttendanceDate(
                            DateTime.now(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _buildDateSelectionTab(
                          icon: Icons.calendar_month,
                          label: 'Another Date',
                          isSelected: !controller.markAttendanceDate.value
                              .isSameDay(DateTime.now()),
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Marking attendance for',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.darkText,
                        ),
                      ),

                      Obx(
                        () => Text(
                          DateFormat(
                            'EEE, MMM dd, yyyy',
                          ).format(controller.markAttendanceDate.value),
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.darkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Single Session Dropdown
                Obx(() => _buildSessionDropdown(
                      label: 'Select Session',
                      value: controller.selectedSession.value,
                      items: controller.todaySessions,
                      onChanged: controller.selectSessionForMarking,
                      hintText: 'Choose a class session',
                    )),
                const SizedBox(height: 16),

                // Filters: Course, Section, Subject, Sub-Subject
                Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: _buildDropdownTile(
                          label: 'Course',
                          value: controller.selectedCourse.value,
                          items: controller.courses,
                          onChanged: controller.selectCourse,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildDropdownTile(
                          label: 'Section',
                          value: controller.selectedSection.value,
                          items: controller.sections,
                          onChanged: controller.selectSection,
                        ),
                      ),
                    ],
                  ),
                ),

            Obx(() =>    _buildDropdownTile(
                  label: 'Subject',
                  value: controller.selectedSubject.value,
                  items: controller.subjects,
                  onChanged: controller.selectSubject,
                ),),
               Obx(() => _buildDropdownTile(
                  label: 'Sub-Subject',
                  value: controller.selectedSubSubject.value,
                  items: controller.subSubjects,
                  onChanged: controller.selectSubSubject,
                  hintText: 'Select Sub-Subject (Optional)',
                ),),
                const SizedBox(height: 16),

                 // Display selected session details
                Obx(() {
                  final session = controller.selectedSession.value;
                  if (session != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Selected Session Details:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                          Text('Course: ${session.displayCourse}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                          Text('Section: ${session.displaySection}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                          Text('Subject: ${session.displaySubject}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                          Text('Time: ${session.displayTime}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                          Text('Session ID: ${session.sessionId}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                          Text('Marking Status: ${session.markingStatus.replaceAll('_', ' ').capitalizeFirst}', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                  onPressed: controller.selectedSession.value == null
                        ? null // Disable if no session is selected
                        : () {
                            Get.to(() => StudentDashboardUploadImage());
                          },
                    icon: const Icon(Icons.edit_note, color: Colors.white),
                    label: const Text(
                      'Mark Attendance',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Show previous attendance toggle
                Obx(
                  () => Row(
                    children: [
                      Switch(
                        padding: EdgeInsets.zero,
                        value: controller.showPreviousAttendance.value,
                        onChanged: controller.toggleShowPreviousAttendance,
                        activeColor: AppColors.primaryBlue,
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          'Show previous attendance',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.darkText,
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          print('View History tapped');
                          // Navigate to attendance history for this class/subject
                        },
                        child: Text(
                          'View History',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Search by name or roll number & Filter
          Container(
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0xFFF4F5F9),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xFFEDEDF1)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 10),
                        decoration: InputDecoration(
                          hintText: 'Search by name or roll no...',
                          hintStyle: TextStyle(fontSize: 10),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.greyText,
                            size: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,

                          fillColor: Colors.grey[100],
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                        ),
                        onChanged: (value) {
                          // Implement search filtering
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {
                        print('Filter tapped');
                      },
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.black,
                        size: 18,
                      ),
                      label: const Text(
                        'Filter',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                //row with 2componts mark all present reset,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.green),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.green.shade100,
                      ),
                      onPressed: () {
                        print('Mark All Present tapped');
                      },
                      child: const Text(
                        'Mark All Present',
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 4),
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        print('Reset tapped');
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Student List for Marking
          Column(
            children: [
              // Header Row
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9FB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('Roll\n No', style: _headerTextStyle()),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('Student Name', style: _headerTextStyle()),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'MARK\nPRESENT / ABSENT / LATE',
                        style: _headerTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
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
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16,
                ),
                child: Obx(() {
                  final presentCount = controller.studentsForMarking
                      .where((s) => s.status.value == 'Present')
                      .length;
                  final absentCount = controller.studentsForMarking
                      .where((s) => s.status.value == 'Absent')
                      .length;
                  final lateCount = controller.studentsForMarking
                      .where((s) => s.status.value == 'Late')
                      .length;
                  final unmarkedCount = controller.studentsForMarking
                      .where((s) => s.status.value == 'Unmarked')
                      .length;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: ${controller.studentsForMarking.length} Students',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.darkText,
                        ),
                      ),
                      Row(
                        children: [
                          _buildStatusCount(
                            presentCount,
                            'Present',
                            AppColors.primaryGreen,
                          ),
                          const SizedBox(width: 8),
                          _buildStatusCount(
                            absentCount,
                            'Absent',
                            AppColors.primaryRed,
                          ),
                          const SizedBox(width: 8),
                          _buildStatusCount(
                            lateCount,
                            'Late',
                            AppColors.primaryOrange,
                          ),
                          const SizedBox(width: 8),
                          _buildStatusCount(
                            unmarkedCount,
                            'Unmarked',
                            AppColors.greyText,
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.submitMarkedAttendance,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Submit Attendance',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelectionTab({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cardBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: AppColors.darkText),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: AppColors.darkText),
            ),
          ],
        ),
      ),
    );
  }

   // Updated dropdown for SessionForMarkingModel
  Widget _buildSessionDropdown({
    required String label,
    required SessionForMarkingModel? value,
    required List<SessionForMarkingModel> items,
    required Function(SessionForMarkingModel?) onChanged,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, color: AppColors.darkText),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.cardBackground,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<SessionForMarkingModel>(
                isExpanded: true,
                value: value,
                hint: Text(
                  hintText ?? 'Select $label',
                  style: TextStyle(color: AppColors.greyText, fontSize: 12),
                ),
                items: items.map((SessionForMarkingModel item) {
                  return DropdownMenuItem<SessionForMarkingModel>(
                    value: item,
                    child: Text(
                      item.displayString, // Use the new displayString
                      style: TextStyle(
                        color: AppColors.darkText,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
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
            style: TextStyle(fontSize: 12, color: AppColors.darkText),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.cardBackground,
            ),
            child: DropdownButtonHideUnderline(
              child: Obx(
                () => DropdownButton<String>(
                  isExpanded: true,
                  value: value.isEmpty ? null : value,
                  hint: Text(
                    hintText ?? 'Select $label',
                    style: TextStyle(color: AppColors.greyText, fontSize: 12),
                  ),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          color: AppColors.darkText,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _headerTextStyle() {
    return TextStyle(fontSize: 10, color: AppColors.greyText);
  }

  Widget _buildStudentAttendanceRow(
    StudentAttendanceMark student,
    FacultyStudentAttendanceController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              student.rollNo,
              style: TextStyle(fontSize: 12, color: AppColors.darkText),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              student.name,
              style: TextStyle(fontSize: 12, color: AppColors.darkText),
            ),
          ),
          Expanded(
            flex: 4,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusButton(
                    Icons.check,
                    'Present',
                    student,
                    controller,
                    AppColors.primaryGreen,
                  ),
                  _buildStatusButton(
                    Icons.close,
                    'Absent',
                    student,
                    controller,
                    AppColors.primaryRed,
                  ),
                  _buildStatusButton(
                    Icons.access_time,
                    'Late',
                    student,
                    controller,
                    AppColors.primaryOrange,
                  ),
                  // If you have a 'Leave' status for marking, add it here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(
    IconData icon,
    String status,
    StudentAttendanceMark student,
    FacultyStudentAttendanceController controller,
    Color color,
  ) {
    bool isSelected = student.status.value == status;
    return GestureDetector(
      onTap: () => controller.updateStudentMarkStatus(student.id, status),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 14,
          color: isSelected ? Colors.white : AppColors.greyText,
        ),
      ),
    );
  }

  Widget _buildStatusCount(int count, String label, Color color) {
    return Text('$count $label', style: TextStyle(fontSize: 10, color: color));
  }
}

// Extension to compare dates without time
extension DateOnlyCompare on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
