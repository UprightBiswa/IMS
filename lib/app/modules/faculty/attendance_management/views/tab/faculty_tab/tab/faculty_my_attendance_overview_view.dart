import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../theme/app_colors.dart';
import '../../../../controllers/faculty_my_attendance_controller.dart';
import '../../../../models/faculty_attendance_model.dart';
import '../../../../widgets/recent_activity_card.dart';

class FacultyMyAttendanceOverviewView extends StatelessWidget {
  FacultyMyAttendanceOverviewView({super.key});

  final controller = Get.find<FacultyMyAttendanceController>();

  Color _getCalendarDotColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return AppColors.presentCalendarDot;
      case 'absent':
        return AppColors.absentCalendarDot;
      case 'late':
        return AppColors.lateCalendarDot;
      case 'leave':
        return AppColors.leaveCalendarDot;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.isError.value) {
        return Center(
          child: Text(
            'Error loading attendance: ${controller.errorMessage.value}',
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      if (controller.calendarDays.isEmpty) {
        return const Center(child: Text('No attendance data available.'));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFEFEFE),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1.6,
                color: const Color(0xFF5F5D5D).withAlpha(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.primaryBlue,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          controller.calendarMonthYear.value,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to full calendar
                      },
                      child: Text(
                        'View Full Calendar',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                _buildCalendarGrid(controller),
                const SizedBox(height: 12),

                // Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLegendItem('Present', AppColors.presentCalendarDot),
                    _buildLegendItem('Absent', AppColors.absentCalendarDot),
                    _buildLegendItem('Late', AppColors.lateCalendarDot),
                    _buildLegendItem('Leave', AppColors.leaveCalendarDot),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const RecentActivityCard(),
        ],
      );
    });
  }

  Widget _buildCalendarGrid(FacultyMyAttendanceController controller) {
    final DateTime firstDayOfMonth = DateTime(2025, 5, 1);
    final int daysInMonth = DateTime(2025, 6, 0).day;
    final int firstWeekday = firstDayOfMonth.weekday;
    final int leadingEmptyCells = firstWeekday == DateTime.sunday
        ? 6
        : firstWeekday - 1;

    return Column(
      children: [
        // Weekday header
        Row(
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),

        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: leadingEmptyCells + daysInMonth,
          itemBuilder: (context, index) {
            if (index < leadingEmptyCells) return const SizedBox();

            final int day = index - leadingEmptyCells + 1;
            final DateTime currentDate = DateTime(
              firstDayOfMonth.year,
              firstDayOfMonth.month,
              day,
            );

            final CalendarDayStatus? dayStatus = controller.calendarDays
                .firstWhereOrNull(
                  (e) =>
                      e.date.day == day &&
                      e.date.month == currentDate.month &&
                      e.date.year == currentDate.year,
                );

            final bool isSelectedDay = currentDate.day == 21;

            return GestureDetector(
              onTap: () => print('Tapped on $currentDate'),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelectedDay
                      ? Border.all(color: AppColors.accentBlue, width: 1.5)
                      : null,
                ),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dayStatus != null && dayStatus.statusCode != 0
                        ? _getCalendarDotColor(
                            dayStatus.status,
                          ).withValues(alpha: .2)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 12,
                        color: dayStatus != null && dayStatus.statusCode != 0
                            ? _getCalendarDotColor(dayStatus.status)
                            : AppColors.darkText,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 11, color: AppColors.greyText)),
      ],
    );
  }
}
