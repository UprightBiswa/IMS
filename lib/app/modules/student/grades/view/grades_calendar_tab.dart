// lib/app/modules/grades/views/tabs/grades_calendar_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../theme/app_colors.dart';
import '../../../../widgets/info_card.dart';
import '../../../../widgets/section_title.dart';
import '../../syllabus/models/syllabus_models.dart';
import '../controllers/grades_controller.dart'; // To use Exam and DailyProgress models

class GradesCalendarTab extends GetView<GradesController> {
  const GradesCalendarTab({super.key});

  Color _getExamStatusDotColor(ExamStatus status) {
    switch (status) {
      case ExamStatus.today:
        return AppColors.examTodayText;
      case ExamStatus.upcoming:
        return AppColors.examUpcomingText;
      case ExamStatus.completed:
        return AppColors.examCompletedText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Calendar Display (similar to Attendance/Syllabus but for grades context) ---
          InfoCard(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => controller.changeCalendarMonth(-1),
                  ),
                  Obx(() => Text(
                    DateFormat('MMM yyyy').format(controller.currentCalendarMonth.value),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => controller.changeCalendarMonth(1),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Days of the week header
              Row(
                children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) => Expanded(
                  child: Center(
                    child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.greyText)),
                  ),
                )).toList(),
              ),
              const SizedBox(height: 8),
              // Calendar Grid
              Obx(() => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemCount: _getCalendarGridSize(controller.currentCalendarMonth.value),
                itemBuilder: (context, index) {
                  final firstDayOfMonth = DateTime(controller.currentCalendarMonth.value.year, controller.currentCalendarMonth.value.month, 1);
                  final leadingEmptyCells = (firstDayOfMonth.weekday == DateTime.sunday) ? 6 : firstDayOfMonth.weekday - 1;
                  final day = index - leadingEmptyCells + 1;

                  if (index < leadingEmptyCells || day > DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0).day) {
                    return Container(); // Empty cells or days beyond month
                  }

                  final date = DateTime(firstDayOfMonth.year, firstDayOfMonth.month, day);
                  final isExamDay = controller.examsForCalendar.any((exam) =>
                  exam.dateTime.year == date.year &&
                      exam.dateTime.month == date.month &&
                      exam.dateTime.day == date.day);

                  final isStudyProgressDay = controller.dailyStudyProgress.any((progress) =>
                  progress.date.year == date.year &&
                      progress.date.month == date.month &&
                      progress.date.day == date.day);

                  final isToday = date.isAtSameMomentAs(DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0));

                  return GestureDetector(
                    onTap: () {
                      Get.snackbar('Calendar', 'Tapped day ${DateFormat('MMM dd').format(date)}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isToday ? AppColors.lightBlue : Colors.transparent,
                        shape: BoxShape.circle,
                        border: isToday ? Border.all(color: AppColors.accentBlue, width: 1.5) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$day',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isToday ? AppColors.accentBlue : AppColors.darkText,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isExamDay)
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryBlue, // Dot for exams
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              if (isStudyProgressDay) // Assuming a different dot for study progress
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryGreen, // Dot for study
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
              const SizedBox(height: 16),
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem(AppColors.primaryBlue, 'Exams'),
                  _buildLegendItem(AppColors.primaryGreen, 'Study Progress'),
                  // Add more legends as needed for assignments, deadlines, etc.
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SectionTitle(title: 'Events for Selected Date'),
          InfoCard(
            children: [
              Text('Select a date to see upcoming exams, assignment deadlines, or study sessions.'),
            ],
          ),
        ],
      ),
    );
  }

  int _getCalendarGridSize(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingEmptyCells = (firstDayOfMonth.weekday == DateTime.sunday) ? 6 : firstDayOfMonth.weekday - 1;
    return leadingEmptyCells + daysInMonth;
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: AppColors.greyText)),
      ],
    );
  }
}