import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../theme/app_colors.dart';
import '../../../controllers/faculty_student_attendance_controller.dart';

class FacultyStudentAttendanceRecordView extends StatelessWidget {
  FacultyStudentAttendanceRecordView({super.key});

  final FacultyStudentAttendanceController controller = Get.find<FacultyStudentAttendanceController>();

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Present': return AppColors.primaryGreen.withOpacity(0.15);
      case 'Absent': return AppColors.primaryRed.withOpacity(0.15);
      case 'Late': return AppColors.primaryOrange.withOpacity(0.15);
      case 'Leave': return AppColors.lightGreyBackground; // or another specific grey
      default: return Colors.transparent;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Present': return AppColors.primaryGreen;
      case 'Absent': return AppColors.primaryRed;
      case 'Late': return AppColors.primaryOrange;
      case 'Leave': return AppColors.greyText;
      default: return AppColors.darkText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // View Toggle: List View / Calendar Show
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: _buildRecordViewTab(
                      label: 'List View',
                      index: 0,
                      isSelected: controller.selectedRecordView.value == 0,
                      onTap: () => controller.changeRecordView(0),
                    ),
                  ),
                  Expanded(
                    child: _buildRecordViewTab(
                      label: 'Calendar Show',
                      index: 1,
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
          _buildDropdownTile(
            label: 'Subject',
            value: controller.selectedRecordSubject.value,
            items: controller.recordSubjects,
            onChanged: controller.selectRecordSubject,
          ),
          _buildDropdownTile(
            label: 'Section',
            value: controller.selectedRecordSection.value,
            items: controller.recordSections,
            onChanged: controller.selectRecordSection,
          ),
          // Date Picker for Record View
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.cardBackground,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text(
                              DateFormat('MMM dd, yyyy').format(controller.recordSelectedDate.value),
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkText,
                              ),
                            )),
                        const Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.greyText),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Search and Filter/Export/Notify buttons
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
                  const PopupMenuItem<String>(value: 'status', child: Text('Filter by Status')),
                  const PopupMenuItem<String>(value: 'date_range', child: Text('Filter by Date Range')),
                ],
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: AppColors.primaryBlue),
                onSelected: (value) {
                  print('Action selected: $value');
                  if (value == 'export') {
                    // Implement export functionality
                    Get.snackbar('Exporting', 'Exporting attendance records...',
                        backgroundColor: Get.theme.colorScheme.secondary, colorText: Get.theme.colorScheme.onSecondary);
                  } else if (value == 'notify') {
                    // Implement notify functionality
                    Get.snackbar('Notifying', 'Sending notifications...',
                        backgroundColor: Get.theme.colorScheme.secondary, colorText: Get.theme.colorScheme.onSecondary);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(value: 'export', child: Text('Export')),
                  const PopupMenuItem<String>(value: 'notify', child: Text('Notify')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Attendance Records List (or Calendar)
          Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
                            Expanded(flex: 1, child: Text('Roll No', style: _headerTextStyle())),
                            Expanded(flex: 3, child: Text('Student Name', style: _headerTextStyle())),
                            Expanded(flex: 2, child: Text('Status', style: _headerTextStyle(), textAlign: TextAlign.center)),
                            Expanded(flex: 1, child: Text('Edit', style: _headerTextStyle(), textAlign: TextAlign.center)),
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
                                Expanded(flex: 1, child: Text(record.rollNo, style: _rowTextStyle())),
                                Expanded(flex: 3, child: Text(record.name, style: _rowTextStyle())),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: _getStatusBgColor(record.status),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        record.status,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getStatusTextColor(record.status),
                                          fontWeight: FontWeight.bold,
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
                                      icon: Icon(Icons.edit, size: 18, color: AppColors.primaryBlue),
                                      onPressed: () {
                                        print('Edit record for ${record.name}');
                                        // Implement edit logic, maybe a dialog
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
                              style: TextStyle(fontSize: 12, color: AppColors.darkText),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print('Download Report tapped');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                              child: const Text('Download Report', style: TextStyle(color: Colors.white)),
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
                      child: Text('Calendar View for Records (To be implemented)'),
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordViewTab({
    required String label,
    required int index,
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

  TextStyle _rowTextStyle() {
    return TextStyle(fontSize: 13, color: AppColors.darkText);
  }
}