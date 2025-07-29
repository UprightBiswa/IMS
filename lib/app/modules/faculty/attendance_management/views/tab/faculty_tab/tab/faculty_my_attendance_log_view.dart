// -----------------------------------------------------------------------------
// Views (lib/app/modules/faculty/attendance_management/views/faculty_my_attendance_log_view.dart) - NEW
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../theme/app_colors.dart';
import '../../../../controllers/faculty_my_attendance_controller.dart';
import '../../../../widgets/attendance_log_card.dart';

class FacultyMyAttendanceLogView
    extends GetView<FacultyMyAttendanceController> {
  const FacultyMyAttendanceLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search and Filter Row
        _buildSearchAndFilterRow(controller),
        const SizedBox(height: 16),
        // Status Filter Tabs
        _buildStatusFilterTabs(controller),
        const SizedBox(height: 16),
        // Attendance Log List
        SizedBox(
          height: MediaQuery.of(context).size.height - 300,
          child: Obx(() {
            if (controller.isLoadingLogs.value &&
                controller.attendanceLogs.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.errorMessage.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            } else if (controller.attendanceLogs.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'No attendance logs found for the selected filters.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () => controller.fetchAttendanceLogs(isRefresh: true),
              child: ListView.builder(
                controller: ScrollController()
                  ..addListener(() {
                    if (controller.hasMoreLogs.value &&
                        !controller.isLoadMoreLoading.value &&
                        ScrollController().position.pixels ==
                            ScrollController().position.maxScrollExtent) {
                      controller.fetchAttendanceLogs();
                    }
                  }),
                itemCount:
                    controller.attendanceLogs.length +
                    (controller.hasMoreLogs.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.attendanceLogs.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final logEntry = controller.attendanceLogs[index];
                  return AttendanceLogCard(logEntry: logEntry);
                },
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
        // Export Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Get.snackbar('Export', 'Exporting attendance report...');
              // Implement export logic
            },
            icon: const Icon(Icons.download),
            label: const Text('Download Attendance Report'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              side: const BorderSide(color: AppColors.primaryBlue),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilterRow(FacultyMyAttendanceController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.logSearchController,
            decoration: InputDecoration(
              hintText: 'Search records...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.filter_list, color: AppColors.primaryBlue),
          onPressed: () {
            _showLogFilterDialog(Get.context!, controller);
          },
        ),
        IconButton(
          icon: const Icon(Icons.date_range, color: AppColors.primaryBlue),
          onPressed: () async {
            DateTimeRange? picked = await showDateRangePicker(
              context: Get.context!,
              initialDateRange: controller.selectedLogDateRangeFilter.value,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            controller.setLogDateRangeFilter(picked);
          },
        ),
      ],
    );
  }

  Widget _buildStatusFilterTabs(FacultyMyAttendanceController controller) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            _buildLogFilterButton(
              'All',
              'All',
              controller.selectedLogStatusFilter.value,
              controller.setLogStatusFilter,
            ),
            _buildLogFilterButton(
              'Present',
              'Present',
              controller.selectedLogStatusFilter.value,
              controller.setLogStatusFilter,
            ),
            _buildLogFilterButton(
              'Absent',
              'Absent',
              controller.selectedLogStatusFilter.value,
              controller.setLogStatusFilter,
            ),
            _buildLogFilterButton(
              'Late',
              'Late',
              controller.selectedLogStatusFilter.value,
              controller.setLogStatusFilter,
            ),
            _buildLogFilterButton(
              'Leave',
              'Leave',
              controller.selectedLogStatusFilter.value,
              controller.setLogStatusFilter,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLogFilterButton(
    String label,
    String value,
    String currentValue,
    Function(String) onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: currentValue == value ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: currentValue == value
                    ? AppColors.primaryBlue
                    : Colors.grey[700],
                fontWeight: currentValue == value
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLogFilterDialog(
    BuildContext context,
    FacultyMyAttendanceController controller,
  ) {
    Get.dialog(
      AlertDialog(
        title: const Text('Filter Attendance Log'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedLogStatusFilter.value,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: ['All', 'Present', 'Absent', 'Late', 'Leave']
                    .map(
                      (status) =>
                          DropdownMenuItem(value: status, child: Text(status)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.setLogStatusFilter(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            // You can add more filters here, e.g., for specific date ranges if not already in main row
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              controller.setLogStatusFilter('All');
              controller.setLogDateRangeFilter(null);
              controller.logSearchController.clear();
              controller.fetchAttendanceLogs(isRefresh: true);
              Get.back();
            },
            child: const Text('Reset Filters'),
          ),
        ],
      ),
    );
  }
}
