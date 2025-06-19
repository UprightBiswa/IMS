import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../theme/app_colors.dart';
import '../../../controllers/faculty_student_attendance_controller.dart';

class FacultyStudentAttendanceRecordView extends StatelessWidget {
  FacultyStudentAttendanceRecordView({super.key});

  final FacultyStudentAttendanceController controller =
      Get.find<FacultyStudentAttendanceController>();

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Present':
        return AppColors.primaryGreen.withValues(alpha: .15);
      case 'Absent':
        return AppColors.primaryRed.withValues(alpha: .15);
      case 'Late':
        return AppColors.primaryOrange.withValues(alpha: .15);
      case 'Leave':
        return AppColors.lightGreyBackground;
      default:
        return Colors.transparent;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Present':
        return AppColors.primaryGreen;
      case 'Absent':
        return AppColors.primaryRed;
      case 'Late':
        return AppColors.primaryOrange;
      case 'Leave':
        return AppColors.greyText;
      default:
        return AppColors.darkText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
          Text(
            'Attendance Records',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          const SizedBox(height: 10),
          // View Toggle: List View / Calendar Show
          Container(
            height: 40,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: _buildRecordViewTab(
                      icon: Icons.list,
                      label: 'List View',
                      isSelected: controller.selectedRecordView.value == 0,
                      onTap: () => controller.changeRecordView(0),
                    ),
                  ),
                  Expanded(
                    child: _buildRecordViewTab(
                      icon: Icons.calendar_today_outlined,
                      label: 'Calendar Show',
                      isSelected: controller.selectedRecordView.value == 1,
                      onTap: () => controller.changeRecordView(1),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 16),

          // Filters: Subject, Section, Date
          Row(
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
                  value: controller.selectedRecordSection.value,
                  items: controller.recordSections,
                  onChanged: controller.selectRecordSection,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildDropdownTile(
                  label: 'Subject',
                  value: controller.selectedRecordSubject.value,
                  items: controller.recordSubjects,
                  onChanged: controller.selectRecordSubject,
                ),
              ),
              const SizedBox(width: 8),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 8),

                      GestureDetector(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.recordSelectedDate.value,
                            firstDate: DateTime(DateTime.now().year - 5),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            controller.selectRecordDate(pickedDate);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.cardBackground,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                  DateFormat(
                                    'MMM dd, yyyy',
                                  ).format(controller.recordSelectedDate.value),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.darkText,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 20,
                                color: AppColors.greyText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Date Picker for Record View
          const SizedBox(height: 16),

          // Search and Filter/Export/Notify buttons
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: 'Search by name or roll no...',
                    hintStyle: TextStyle(fontSize: 12),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.greyText,
                      size: 16,
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
                  onChanged: controller.updateRecordSearchQuery,
                ),
              ),
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                icon: Icon(Icons.tune, color: AppColors.primaryBlue),
                onSelected: (value) {
                  print('Filter option selected: $value');
                  // Implement more advanced filtering logic
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'status',
                    child: Text('Filter by Status'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'date_range',
                    child: Text('Filter by Date Range'),
                  ),
                ],
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: AppColors.primaryBlue),
                onSelected: (value) {
                  print('Action selected: $value');
                  if (value == 'export') {
                    // Implement export functionality
                    Get.snackbar(
                      'Exporting',
                      'Exporting attendance records...',
                      backgroundColor: Get.theme.colorScheme.secondary,
                      colorText: Get.theme.colorScheme.onSecondary,
                    );
                  } else if (value == 'notify') {
                    // Implement notify functionality
                    Get.snackbar(
                      'Notifying',
                      'Sending notifications...',
                      backgroundColor: Get.theme.colorScheme.secondary,
                      colorText: Get.theme.colorScheme.onSecondary,
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'export',
                    child: Text('Export'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'notify',
                    child: Text('Notify'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Attendance Records List (or Calendar)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFEFEFE),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 1.6,
                color: const Color(0xFF5F5D5D).withValues(alpha: .1),
              ),
            ),
            child: Obx(() {
              if (controller.selectedRecordView.value == 0) {
                // List View
                return Column(
                  children: [
                    // Table Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text('Roll\n No', style: _headerTextStyle()),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Student Name',
                              style: _headerTextStyle(),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Status',
                              style: _headerTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Edit',
                              style: _headerTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1, thickness: 0.5),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.studentRecords.length,
                      itemBuilder: (context, index) {
                        final record = controller.studentRecords[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  record.rollNo,
                                  style: _rowTextStyle(),
                                ),
                              ),
                              Expanded(
                                flex: 3,

                                child: Text(
                                  record.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: _rowTextStyle(),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusBgColor(record.status),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      record.status,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getStatusTextColor(
                                          record.status,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      size: 18,
                                      color: AppColors.primaryBlue,
                                    ),
                                    onPressed: () {
                                      print('Edit record for ${record.name}');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, thickness: 0.5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: ${controller.studentRecords.length} Students',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkText,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print('Download Report tapped');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            child: const Text(
                              'Download Report',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Calendar Show (Placeholder)
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Text(
                      'Calendar View for Records (To be implemented)',
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordViewTab({
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
              border: Border.all(color: Colors.grey.shade300),
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

  TextStyle _rowTextStyle() {
    return TextStyle(fontSize: 13, color: AppColors.darkText);
  }
}
