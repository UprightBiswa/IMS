// lib/app/modules/assignments/views/assignment_calendar_overview_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart'; // Add table_calendar to pubspec.yaml

import '../../../../theme/app_colors.dart';
import '../controllers/assingment_controller.dart';
import '../models/assignment_model.dart';
import '../widgets/assignment_list_card.dart';
import 'assignment_submit_tab.dart'; // Re-use assignment list card

class AssignmentCalendarOverviewTab extends StatefulWidget {
  const AssignmentCalendarOverviewTab({super.key});

  @override
  State<AssignmentCalendarOverviewTab> createState() => _AssignmentCalendarOverviewTabState();
}

class _AssignmentCalendarOverviewTabState extends State<AssignmentCalendarOverviewTab> {
  final AssignmentController controller = Get.find<AssignmentController>();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Assignment>> _events = {}; // Map for events

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents();
    // Listen for changes in allAssignments to update calendar events
    controller.allAssignments.listen((_) {
      _loadEvents();
      if (mounted) setState(() {}); // Trigger rebuild if assignments change
    });
  }

  void _loadEvents() {
    _events = {};
    for (var assignment in controller.allAssignments) {
      final normalizedDate = DateTime(assignment.dueDate.year, assignment.dueDate.month, assignment.dueDate.day);
      if (_events[normalizedDate] == null) {
        _events[normalizedDate] = [];
      }
      _events[normalizedDate]!.add(assignment);
    }
  }

  List<Assignment> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TableCalendar<Assignment>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(
                  color: AppColors.primaryBlue, // Light blue for today
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primaryBlue, // Primary blue for selected day
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.red[300], // Small red dot for events
                  shape: BoxShape.circle,
                ),
                outsideDaysVisible: false,
                markerSize: 5.0,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
                leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.textBlack),
                rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.textBlack),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // List of assignments for the selected day
          if (_selectedDay != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assignments for ${DateFormat('MMM dd, yyyy').format(_selectedDay!)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_getEventsForDay(_selectedDay!).isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('No assignments on this day.', style: TextStyle(color: Colors.grey)),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _getEventsForDay(_selectedDay!).length,
                      itemBuilder: (context, index) {
                        final assignment = _getEventsForDay(_selectedDay!)[index];
                        return AssignmentListCard(
                          assignment: assignment,
                          onTap: () {
                            Get.to(() => AssignmentDetailsScreen(assignment: assignment));
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}