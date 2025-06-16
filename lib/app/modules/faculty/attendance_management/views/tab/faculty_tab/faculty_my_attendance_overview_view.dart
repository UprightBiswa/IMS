import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../theme/app_colors.dart';
import '../../../controllers/faculty_my_attendance_controller.dart';
import '../../../models/faculty_attendance_model.dart';
import '../../../widgets/recent_activity_card.dart';

class FacultyMyAttendanceOverviewView extends StatelessWidget {
  FacultyMyAttendanceOverviewView({super.key});

  final FacultyMyAttendanceController controller = Get.put(
    FacultyMyAttendanceController(),
  );

  Color _getCalendarDotColor(int status) {
    switch (status) {
      case 1:
        return AppColors.presentCalendarDot; // Present
      case 2:
        return AppColors.absentCalendarDot; // Absent
      case 3:
        return AppColors.lateCalendarDot; // Late
      case 4:
        return AppColors.leaveCalendarDot; // Leave
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        'May 2025',
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
                      print('View Full Calendar tapped');
                      // Navigate to full calendar view
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

              _buildCalendarGrid(controller),
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
        const RecentActivityCard(),
      ],
    );
  }

  Widget _buildCalendarGrid(FacultyMyAttendanceController controller) {
    final DateTime firstDayOfMonth = DateTime(2025, 5, 1);
    final int daysInMonth = DateTime(2025, 5 + 1, 0).day;
    final int firstWeekday = firstDayOfMonth.weekday;

    final int leadingEmptyCells = (firstWeekday == DateTime.sunday)
        ? 6
        : firstWeekday - 1;

    return Column(
      children: [
        Row(
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
              .map(
                (day) => Expanded(
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
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
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
            if (index < leadingEmptyCells) {
              return Container();
            }
            final int day = index - leadingEmptyCells + 1;
            final DateTime currentDate = DateTime(
              firstDayOfMonth.year,
              firstDayOfMonth.month,
              day,
            );
            final CalendarDayStatus? dayStatus = controller.calendarDays
                .firstWhereOrNull(
                  (element) =>
                      element.date.day == day &&
                      element.date.month == currentDate.month &&
                      element.date.year == currentDate.year,
                );

            final bool isSelectedDay = day == 21;

            return GestureDetector(
              onTap: () {
                print('Tapped day: $day');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelectedDay
                      ? AppColors.lightBlue
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: isSelectedDay
                      ? Border.all(color: AppColors.accentBlue, width: 1.5)
                      : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelectedDay
                            ? AppColors.accentBlue
                            : AppColors.darkText,
                      ),
                    ),
                    if (dayStatus != null && dayStatus.status != 0)
                      Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: _getCalendarDotColor(dayStatus.status),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 11, color: AppColors.greyText)),
      ],
    );
  }
}
