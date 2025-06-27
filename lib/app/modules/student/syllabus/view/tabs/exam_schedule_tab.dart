// lib/app/modules/syllabus/views/tabs/exam_schedule_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../theme/app_colors.dart';
import '../../controllers/syllabus_controller.dart';
import '../../models/syllabus_models.dart';

class ExamScheduleTab extends GetView<SyllabusController> {
  const ExamScheduleTab({super.key});

  Color _getExamStatusBgColor(ExamStatus status) {
    switch (status) {
      case ExamStatus.today:
        return AppColors.examTodayBg;
      case ExamStatus.upcoming:
        return AppColors.examUpcomingBg;
      case ExamStatus.completed:
        return AppColors.examCompletedBg;
    }
  }

  Color _getExamStatusTextColor(ExamStatus status) {
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
          const Text(
            'Exam Schedule',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.darkText,
            ),
          ),

          Obx(
            () => Text(
              controller.userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.darkText,
              ),
            ),
          ),
          Obx(
            () => Text(
              'Roll No: ${controller.userRollNumber}',
              style: const TextStyle(fontSize: 14, color: AppColors.greyText),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.settingsCardBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: .1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkText,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.examUpcomingBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Obx(
                        () => Text(
                          'Next exam in ${controller.nextExamInDays.value}',
                          style: const TextStyle(
                            color: AppColors.examUpcomingText,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildExamSummaryItem(
                      'Total Exams',
                      controller.totalExams.value.toString(),
                      AppColors.primaryBlue,
                    ),
                    _buildExamSummaryItem(
                      'Completed',
                      controller.completedExams.value.toString(),
                      AppColors.presentGreen,
                    ),
                    _buildExamSummaryItem(
                      'Remaining',
                      controller.remainingExams.value.toString(),
                      AppColors.primaryRed,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Row(
                  spacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Get.snackbar('Action', 'Download Schedule');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        side: const BorderSide(color: AppColors.primaryBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                      ),
                      child: const Text(
                        'Download Schedule',
                        style: TextStyle(color: AppColors.white, fontSize: 10),
                      ),
                    ),

                    OutlinedButton(
                      onPressed: () {
                        Get.snackbar('Action', 'Set Reminders');
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.backgroundGray,

                        side: const BorderSide(color: AppColors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                      ),
                      child: const Text(
                        'Set Reminders',
                        style: TextStyle(
                          color: AppColors.darkText,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- Calendar Section ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.settingsCardBorder, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: .1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Obx(
                      () => Expanded(
                        child: Text(
                          DateFormat(
                            'MMM yyyy',
                          ).format(controller.currentCalendarMonth.value),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 12),
                      onPressed: () => controller.changeCalendarMonth(-1),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 12),
                      onPressed: () => controller.changeCalendarMonth(1),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Days of the week header
                Row(
                  children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                      .map(
                        (day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.greyText,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                // Calendar Grid
                Obx(
                  () => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                    itemCount: _getCalendarGridSize(
                      controller.currentCalendarMonth.value,
                    ),
                    itemBuilder: (context, index) {
                      final firstDayOfMonth = DateTime(
                        controller.currentCalendarMonth.value.year,
                        controller.currentCalendarMonth.value.month,
                        1,
                      );
                      final leadingEmptyCells =
                          (firstDayOfMonth.weekday == DateTime.sunday)
                          ? 6
                          : firstDayOfMonth.weekday - 1;
                      final day = index - leadingEmptyCells + 1;

                      if (index < leadingEmptyCells ||
                          day >
                              DateTime(
                                firstDayOfMonth.year,
                                firstDayOfMonth.month + 1,
                                0,
                              ).day) {
                        return Container(); // Empty cells or days beyond month
                      }

                      final date = DateTime(
                        firstDayOfMonth.year,
                        firstDayOfMonth.month,
                        day,
                      );
                      final isExamDay = controller.examsList.any(
                        (exam) =>
                            exam.dateTime.year == date.year &&
                            exam.dateTime.month == date.month &&
                            exam.dateTime.day == date.day,
                      );

                      final isSelectedDay =
                          date.day == 26 &&
                          date.month ==
                              controller
                                  .currentCalendarMonth
                                  .value
                                  .month; // Example: day 26 is selected in image
                      final isToday = date.isAtSameMomentAs(
                        DateTime.now().copyWith(
                          hour: 0,
                          minute: 0,
                          second: 0,
                          millisecond: 0,
                          microsecond: 0,
                        ),
                      );

                      return GestureDetector(
                        onTap: () {
                          Get.snackbar(
                            'Calendar',
                            'Tapped day ${DateFormat('MMM dd').format(date)}',
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelectedDay
                                ? AppColors.lightBlue
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: isSelectedDay
                                ? Border.all(
                                    color: AppColors.accentBlue,
                                    width: 1.5,
                                  )
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
                                      : (isToday
                                            ? AppColors.primaryBlue
                                            : AppColors.darkText),
                                ),
                              ),
                              if (isExamDay)
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: AppColors
                                        .primaryBlue, // Dot for exam days
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- Filter Buttons (All, Upcoming, Today, Completed) ---
          Obx(
            () => Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildExamFilterButton('All', 0),
                _buildExamFilterButton('Upcoming', 1),
                _buildExamFilterButton('Today', 2),
                _buildExamFilterButton('Completed', 3),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // --- Exam List (Filtered by selectedExamFilter) ---
          Obx(() {
            final filteredExams = controller.examsList.where((exam) {
              if (controller.selectedExamFilter.value == 0) return true; // All
              if (controller.selectedExamFilter.value == 1) {
                return exam.status == ExamStatus.upcoming;
              }
              if (controller.selectedExamFilter.value == 2) {
                return exam.status == ExamStatus.today;
              }
              if (controller.selectedExamFilter.value == 3) {
                return exam.status == ExamStatus.completed;
              }
              return true;
            }).toList();

            if (filteredExams.isEmpty) {
              return const Center(
                child: Text('No exams found for this filter.'),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredExams.length,
              itemBuilder: (context, index) {
                final exam = filteredExams[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildExamCard(exam),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  int _getCalendarGridSize(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingEmptyCells = (firstDayOfMonth.weekday == DateTime.sunday)
        ? 6
        : firstDayOfMonth.weekday - 1;
    return leadingEmptyCells + daysInMonth;
  }

  Widget _buildExamSummaryItem(String label, String value, Color? valueColor) {
    return Expanded(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.backgroundGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: valueColor ?? AppColors.darkText,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: valueColor ?? AppColors.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamFilterButton(String label, int index) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.changeExamFilter(index),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: controller.selectedExamFilter.value == index
                ? AppColors.primaryBlue
                : AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: controller.selectedExamFilter.value == index
                  ? AppColors.white
                  : AppColors.greyText,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamCard(Exam exam) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: _getExamStatusTextColor(exam.status),
            width: 4,
          ),
        ),
        borderRadius: BorderRadius.circular(8),
        color: exam.status == ExamStatus.today
            ? AppColors.accentBlue.withValues(alpha: .1)
            : AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exam.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getExamStatusBgColor(exam.status),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  exam.status == ExamStatus.upcoming
                      ? 'IN ${exam.dateTime.difference(DateTime.now()).inDays} DAYS'
                      : exam.status.toString().split('.').last.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _getExamStatusTextColor(exam.status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            exam.instructor,
            style: const TextStyle(fontSize: 12, color: AppColors.greyText),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: AppColors.greyText,
              ),
              const SizedBox(width: 4),
              Text(
                DateFormat('MMM dd, yyyy').format(exam.dateTime),
                style: const TextStyle(fontSize: 12, color: AppColors.greyText),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 14, color: AppColors.greyText),
              const SizedBox(width: 4),
              Text(
                DateFormat('hh:mm a').format(exam.dateTime),
                style: const TextStyle(fontSize: 12, color: AppColors.greyText),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppColors.greyText,
              ),
              const SizedBox(width: 4),
              Text(
                exam.location,
                style: const TextStyle(fontSize: 12, color: AppColors.greyText),
              ),
              const SizedBox(width: 16),
              Icon(Icons.hourglass_empty, size: 14, color: AppColors.greyText),
              const SizedBox(width: 4),
              Text(
                exam.duration,
                style: const TextStyle(fontSize: 12, color: AppColors.greyText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
