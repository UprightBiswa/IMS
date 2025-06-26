import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'apply_leave_screen.dart';

class AttendanceLeaveTab extends StatelessWidget {
  const AttendanceLeaveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [LeaveRequestsScreen()],
    );
  }
}

class LeaveRequestsScreen extends StatefulWidget {
  const LeaveRequestsScreen({super.key});

  @override
  State<LeaveRequestsScreen> createState() => _LeaveRequestsScreenState();
}

class _LeaveRequestsScreenState extends State<LeaveRequestsScreen> {
  int _selectedTab = 0; // 0 for Leave History, 1 for Pending Requests

  @override
  Widget build(BuildContext context) {
    return _buildLeaveRequestsContainer();
  }

  Widget _buildLeaveRequestsContainer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Color(0xFFE2E2E3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Leave Requests',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Get.to(() => const ApplyLeaveScreen());
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Apply for Leave'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[700], // Text and icon color
                  side: BorderSide(color: Colors.grey[400]!), // Border color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Segmented Control (Tabs)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Background for the segmented control
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildSegmentButton(
                    label: 'Leave History',
                    index: 0,
                    isSelected: _selectedTab == 0,
                    onTap: () {
                      setState(() {
                        _selectedTab = 0;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: _buildSegmentButton(
                    label: 'Pending Requests',
                    index: 1,
                    isSelected: _selectedTab == 1,
                    onTap: () {
                      setState(() {
                        _selectedTab = 1;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Leave Request List (conditionally rendered based on _selectedTab)
          if (_selectedTab == 0) // Show Leave History
            Column(
              children: [
                _buildLeaveRequestCard(
                  date: '2025-04-10 to 2025-04-12',
                  reason: 'Medical emergency',
                  submittedDate: '2025-04-08',
                  status: 'Approved',
                ),
                const SizedBox(height: 12),
                _buildLeaveRequestCard(
                  date: '2025-03-20',
                  reason: 'Personal reasons',
                  submittedDate: '2025-03-18',
                  status: 'Rejected',
                ),
                const SizedBox(height: 12),
                // Add more leave request cards here if needed
              ],
            )
          else // Show Pending Requests (Placeholder)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'No Pending Requests',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({
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
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[700],
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveRequestCard({
    required String date,
    required String reason,
    required String submittedDate,
    required String status,
  }) {
    Color statusColor;
    IconData statusIcon;
    Color statusTextColor;

    if (status == 'Approved') {
      statusColor = Colors.green[50]!; // Very light green background
      statusIcon = Icons.check_circle;
      statusTextColor = Colors.green[700]!; // Darker green text
    } else if (status == 'Rejected') {
      statusColor = Colors.red[50]!; // Very light red background
      statusIcon = Icons.cancel;
      statusTextColor = Colors.red[700]!; // Darker red text
    } else {
      statusColor = Colors.grey[50]!; // Default for other statuses
      statusIcon = Icons.info;
      statusTextColor = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xFFEAEAEA), width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 10, color: statusTextColor),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: statusTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason: $reason',
                      style: const TextStyle(fontSize: 8, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Submitted on $submittedDate',
                      style: const TextStyle(fontSize: 8, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () {
                  // Handle download letter tap
                  print('Download Letter tapped for $date');
                },
                icon: const Icon(Icons.download, size: 18),
                label: const Text(
                  'Download Letter',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[700], // Text and icon color
                  side: BorderSide(color: Colors.grey[400]!), // Border color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
