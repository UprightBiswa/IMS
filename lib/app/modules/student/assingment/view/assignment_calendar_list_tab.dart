// lib/app/modules/assignments/views/assignment_calendar_list_tab.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/section_title.dart';
import '../controllers/assingment_controller.dart';
import '../models/assignment_model.dart';
import '../widgets/assignment_list_card.dart';
import 'assignment_submit_tab.dart';

class AssignmentCalendarListTab extends GetView<AssignmentController> {
  const AssignmentCalendarListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sortedAssignments = controller.allAssignments.toList()
        ..sort((a, b) => a.dueDate.compareTo(b.dueDate));

      if (sortedAssignments.isEmpty) {
        return const Center(
          child: Text('No assignments to display in the list.', style: TextStyle(color: Colors.grey)),
        );
      }

      // Group assignments by month/year
      final Map<String, List<Assignment>> groupedAssignments = {};
      for (var assignment in sortedAssignments) {
        final monthYear = DateFormat('MMMM yyyy').format(assignment.dueDate);
        if (!groupedAssignments.containsKey(monthYear)) {
          groupedAssignments[monthYear] = [];
        }
        groupedAssignments[monthYear]!.add(assignment);
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: groupedAssignments.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(title: entry.key), // Month and Year as section title
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: entry.value.length,
                  itemBuilder: (context, index) {
                    final assignment = entry.value[index];
                    return AssignmentListCard(
                      assignment: assignment,
                      onTap: () {
                        Get.to(() => AssignmentDetailsScreen(assignment: assignment));
                      },
                    );
                  },
                ),
                const SizedBox(height: 24), // Space between months
              ],
            );
          }).toList(),
        ),
      );
    });
  }
}