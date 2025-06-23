import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../theme/app_colors.dart';
import '../controllers/faculty_my_attendance_controller.dart';

class LeaveBalanceCard extends StatelessWidget {
  const LeaveBalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FacultyMyAttendanceController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.isError.value) {
        return Center(
          child: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      final balance = controller.leaveBalance.value;

      if (balance == null) {
        return const Center(child: Text("No leave balance data available."));
      }
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1.6,
            color: const Color(0xFF5F5D5D).withValues(alpha: .1),
          ),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.primaryBlue,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'Leave Management',
              style: TextStyle(fontSize: 16, color: AppColors.darkText),
            ),
            const SizedBox(height: 8),
            Text(
              'Apply for your leave and view your leav history',
              style: TextStyle(fontSize: 12, color: AppColors.greyText),
            ),
            const SizedBox(height: 8),
            //buttion primary Apply for new leave
            SizedBox(
              width: 240,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => ApplyForLeaveView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  'Apply for New Leave',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leave Balances',
                  style: TextStyle(fontSize: 12, color: AppColors.darkText),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLeaveItem('Casual', balance.casual),
                    _buildLeaveItem('Sick', balance.sick),
                    _buildLeaveItem('Earned', balance.earned),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildLeaveItem(String type, int count) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 70,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.greyText,
              ),
            ),
            Text(
              type,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: AppColors.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplyForLeaveView extends StatelessWidget {
  ApplyForLeaveView({super.key});

  final FacultyMyAttendanceController controller =
      Get.find<FacultyMyAttendanceController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyBackground,
      appBar: AppBar(
        title: const Text(
          'Apply for Leave',
          style: TextStyle(color: AppColors.darkText),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.darkText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fill this form to submit a leave request to your department',
                style: TextStyle(fontSize: 14, color: AppColors.greyText),
              ),
              const SizedBox(height: 20),

              // Date Range
              Text(
                'Date Range',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                controller.selectedLeaveStartDate.value ??
                                DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (pickedDate != null) {
                            controller.selectedLeaveStartDate.value =
                                pickedDate;
                            if (controller.isSingleDayLeave.value) {
                              controller.selectedLeaveEndDate.value =
                                  pickedDate;
                            }
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
                              Text(
                                controller.selectedLeaveStartDate.value == null
                                    ? 'Select Date'
                                    : DateFormat('MMM dd, yyyy').format(
                                        controller
                                            .selectedLeaveStartDate
                                            .value!,
                                      ),
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      controller.selectedLeaveStartDate.value ==
                                          null
                                      ? AppColors.greyText
                                      : AppColors.darkText,
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
                    ),
                    const SizedBox(width: 8),
                    // "1 Day" / "Multi-Day" Toggle
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(
                        () => Row(
                          children: [
                            _buildDateToggle(
                              label: '1 Day',
                              isSelected: controller.isSingleDayLeave.value,
                              onTap: () => controller.toggleLeaveType(true),
                            ),
                            _buildDateToggle(
                              label: 'Multi-Day',
                              isSelected: !controller.isSingleDayLeave.value,
                              onTap: () => controller.toggleLeaveType(false),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // End Date for Multi-Day Leave
              Obx(
                () => Visibility(
                  visible: !controller.isSingleDayLeave.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Date',
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
                            initialDate:
                                controller.selectedLeaveEndDate.value ??
                                controller.selectedLeaveStartDate.value ??
                                DateTime.now(),
                            firstDate:
                                controller.selectedLeaveStartDate.value ??
                                DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                          );
                          if (pickedDate != null) {
                            controller.selectedLeaveEndDate.value = pickedDate;
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
                              Text(
                                controller.selectedLeaveEndDate.value == null
                                    ? 'Select End Date'
                                    : DateFormat('MMM dd, yyyy').format(
                                        controller.selectedLeaveEndDate.value!,
                                      ),
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      controller.selectedLeaveEndDate.value ==
                                          null
                                      ? AppColors.greyText
                                      : AppColors.darkText,
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
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Leave Type
              Text(
                'Leave Type',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.cardBackground,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.selectedLeaveType.value.isEmpty
                          ? null
                          : controller.selectedLeaveType.value,
                      hint: Text(
                        'Select Leave type',
                        style: TextStyle(color: AppColors.greyText),
                      ),
                      items: controller.leaveTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: TextStyle(color: AppColors.darkText),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.selectedLeaveType.value = newValue;
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Reason for Leave
              Text(
                'Reason for Leave',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: TextEditingController(
                  text: controller.leaveReason.value,
                ),
                onChanged: controller.updateLeaveReason,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write here....',
                  hintStyle: TextStyle(color: AppColors.greyText),
                  filled: true,
                  fillColor: AppColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primaryBlue),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Reason cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Supporting Documents (Optional)
              Text(
                'Supporting Documents (Optional)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 40,
                      color: AppColors.greyText,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Click to upload or Drag and drop',
                      style: TextStyle(fontSize: 13, color: AppColors.darkText),
                    ),
                    Text(
                      'PDF, JPG, PNG (max. 5MB)',
                      style: TextStyle(fontSize: 11, color: AppColors.greyText),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        print('Choose File tapped');
                        // Implement file picker logic
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        side: BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Choose File'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Note section
              Text(
                'Note: By submitting this leave request, you acknowledge that:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 8),
              _buildNotePoint(
                'Faculty may require additional documentation for leaves exceeding 3 days',
              ),
              _buildNotePoint(
                'Approval is subject to departmental policies and attendance requirements',
              ),
              _buildNotePoint(
                'Leaves during examination periods require special approval',
              ),
              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Get.back(); // Go back without submitting
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                        side: BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.submitLeaveRequest();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Submit Request',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Icon(Icons.circle, size: 6, color: AppColors.greyText),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: AppColors.greyText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateToggle({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.primaryBlue : Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
