// -----------------------------------------------------------------------------
// Views (lib/app/modules/admin/leave_management/views/admin_leave_management_view.dart)
// -----------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../controllers/admin_leave_controller.dart';
import 'admin_leave_request_card.dart';
import 'admin_leave_summary_card.dart';

class AdminLeaveManagementView extends GetView<AdminLeaveController> {
  const AdminLeaveManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = controller.scrollController;
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: const CustomAppBar(
        title: 'Leave Management',
        showDrawerIcon: false,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isLoadMoreLoading.value &&
              controller.hasMoreApplications.value &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            controller.fetchAdminLeaveApplications();
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchAdminLeaveApplications(isRefresh: true);
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              // HEADER: Welcome + Filters
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back, Admin!',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.primaryBlue,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Leave Management',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSummarySection(controller),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: AppColors.primaryBlue,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Leave Requests',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildFilterSection(controller),
                      const SizedBox(height: 16),
                      _buildSearchAndFilterRow(controller),
                    ],
                  ),
                ),
              ),

              // CONTENT: Leave Applications
              Obx(() {
                if (controller.isLoadingApplications.value &&
                    controller.leaveApplications.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (controller.errorMessage.isNotEmpty) {
                  return SliverFillRemaining(
                    child: Center(child: Text(controller.errorMessage.value)),
                  );
                } else if (controller.leaveApplications.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No leave applications found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == controller.leaveApplications.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final leave = controller.leaveApplications[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AdminLeaveRequestCard(
                          leave: leave,
                          controller: controller,
                        ),
                      );
                    },
                    childCount:
                        controller.leaveApplications.length +
                        (controller.hasMoreApplications.value ? 1 : 0),
                  ),
                );
              }),

              // BOTTOM SPACER
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection(AdminLeaveController controller) {
    return Obx(() {
      final summary = controller.leaveSummary.value;
      if (controller.isLoadingSummary.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return Column(
        children: [
          Row(
            children: [
              AdminLeaveSummaryCard(
                title: 'Total Requests',
                value: (summary?.totalRequests ?? 0).toString(),
                subtitle: 'This Month',
                backgroundColor: AppColors.white,
                textColor: AppColors.textBlack,
              ),
              const SizedBox(width: 12),
              AdminLeaveSummaryCard(
                title: 'Pending',
                value: (summary?.pending ?? 0).toString(),
                subtitle: 'Approval Now',
                backgroundColor: AppColors.white,
                textColor: AppColors.textBlack,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              AdminLeaveSummaryCard(
                title: 'Approved',
                value: (summary?.approved ?? 0).toString(),
                subtitle: 'This Month',
                backgroundColor: AppColors.white,
                textColor: AppColors.textBlack,
              ),
              const SizedBox(width: 12),
              AdminLeaveSummaryCard(
                title: 'Rejected',
                value: (summary?.rejected ?? 0).toString(),
                subtitle: 'Approval Now',
                backgroundColor: AppColors.white,
                textColor: AppColors.textBlack,
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildFilterSection(AdminLeaveController controller) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            _buildFilterButton(
              'All',
              'all',
              controller.selectedStatusFilter.value,
              controller.setStatusFilter,
            ),
            _buildFilterButton(
              'Pending',
              'pending',
              controller.selectedStatusFilter.value,
              controller.setStatusFilter,
            ),
            _buildFilterButton(
              'Approved',
              'approved',
              controller.selectedStatusFilter.value,
              controller.setStatusFilter,
            ),
            _buildFilterButton(
              'Rejected',
              'rejected',
              controller.selectedStatusFilter.value,
              controller.setStatusFilter,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFilterButton(
    String label,
    String value,
    String currentValue,
    Function(String) onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: currentValue == value ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
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

  Widget _buildSearchAndFilterRow(AdminLeaveController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.searchController,
            decoration: InputDecoration(
              hintText: 'Search...',
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
            // Show advanced filters (e.g., date range, leave type)
            _showAdvancedFilterDialog(Get.context!, controller);
          },
        ),
        IconButton(
          icon: const Icon(Icons.date_range, color: AppColors.primaryBlue),
          onPressed: () async {
            DateTimeRange? picked = await showDateRangePicker(
              context: Get.context!,
              initialDateRange: controller.selectedDateRangeFilter.value,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            controller.setDateRangeFilter(picked);
          },
        ),
        IconButton(
          icon: const Icon(Icons.download, color: AppColors.primaryBlue),
          onPressed: () {
            Get.snackbar('Download', 'Initiating download of leave data.');
            // Implement actual download logic here
          },
        ),
      ],
    );
  }

  void _showAdvancedFilterDialog(
    BuildContext context,
    AdminLeaveController controller,
  ) {
    Get.dialog(
      AlertDialog(
        title: const Text('Advanced Filters'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.selectedLeaveTypeFilter.value,
                decoration: const InputDecoration(
                  labelText: 'Leave Type',
                  border: OutlineInputBorder(),
                ),
                items: ['all', 'sick', 'casual']
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.capitalizeFirst!),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.setLeaveTypeFilter(value);
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            // You can add more filters here, e.g., for specific users/departments
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
              controller.selectedLeaveTypeFilter.value = 'all';
              controller.selectedDateRangeFilter.value = null;
              controller.searchController.clear();
              controller.fetchAdminLeaveApplications(isRefresh: true);
              Get.back();
            },
            child: const Text('Reset Filters'),
          ),
        ],
      ),
    );
  }
}
