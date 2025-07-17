import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/leave_controller.dart';
import '../models/leave_application_model.dart';
import 'apply_leave_screen.dart';

// -----------------------------------------------------------------------------
// AttendanceLeaveTab (lib/app/modules/student/attendance/views/attendance_leave_tab.dart) - Updated
// -----------------------------------------------------------------------------
class AttendanceLeaveTab extends StatelessWidget {
  const AttendanceLeaveTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LeaveController here, so it's available for its children
    Get.put(LeaveController());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: const LeaveRequestsScreen(),
    );
  }
}

class LeaveRequestsScreen extends StatefulWidget {
  const LeaveRequestsScreen({super.key});

  @override
  State<LeaveRequestsScreen> createState() => _LeaveRequestsScreenState();
}

class _LeaveRequestsScreenState extends State<LeaveRequestsScreen> {
  final LeaveController _controller = Get.find();
  final ScrollController _scrollController = ScrollController();
  int _selectedTab = 0; // 0 for Leave History, 1 for Pending Requests

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Initial fetch is handled by controller's onInit
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_selectedTab == 0) {
        if (_controller.hasMoreHistory.value &&
            !_controller.isLoadMoreLoading.value) {
          _controller.isLoadMoreLoading.value =
              true; // Set loading state for load more
          _controller.fetchLeaveApplications(false); // Load more history
        }
      } else {
        if (_controller.hasMorePending.value &&
            !_controller.isLoadMoreLoading.value) {
          _controller.isLoadMoreLoading.value =
              true; // Set loading state for load more
          _controller.fetchLeaveApplications(true); // Load more pending
        }
      }
    }
  }

  Future<void> _onRefresh() async {
    if (_selectedTab == 0) {
      await _controller.fetchLeaveApplications(false, isRefresh: true);
    } else {
      await _controller.fetchLeaveApplications(true, isRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE2E2E3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  _controller
                      .resetApplyLeaveForm(); // Reset form before navigating
                  Get.to(() => const ApplyLeaveScreen());
                },
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Apply for Leave'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                  side: BorderSide(color: Colors.grey[400]!),
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
              color: Colors.grey[200],
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
                      _controller.fetchLeaveApplications(
                        false,
                        isRefresh: true,
                      );
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
                      _controller.fetchLeaveApplications(true, isRefresh: true);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Leave Request List (conditionally rendered based on _selectedTab)
          Flexible(
            fit: FlexFit.loose,
            // Use Flexible with loose fit to avoid unbounded height error
            child: Obx(() {
              final List<LeaveApplicationModel> currentList = _selectedTab == 0
                  ? _controller.leaveHistory
                  : _controller.pendingRequests;
              final bool hasMore = _selectedTab == 0
                  ? _controller.hasMoreHistory.value
                  : _controller.hasMorePending.value;

              if (_controller.isLoading.value && currentList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (_controller.errorMessage.isNotEmpty) {
                return Center(child: Text(_controller.errorMessage.value));
              } else if (currentList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      _selectedTab == 0
                          ? 'No Leave History Available'
                          : 'No Pending Requests',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount:
                      currentList.length +
                      (hasMore ? 1 : 0), // Add 1 for loading indicator
                  itemBuilder: (context, index) {
                    if (index == currentList.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: _controller.isLoadMoreLoading.value
                              ? const CircularProgressIndicator()
                              : const SizedBox.shrink(), // No more data
                        ),
                      );
                    }
                    final leave = currentList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildLeaveRequestCard(leave),
                    );
                  },
                ),
              );
            }),
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

  Widget _buildLeaveRequestCard(LeaveApplicationModel leave) {
    Color statusColor;
    IconData statusIcon;
    Color statusTextColor;

    // Determine status color and icon based on final_status or status
    String displayStatus = leave.finalStatus ?? leave.status;

    if (displayStatus == 'approved' || displayStatus == 'faculty_approved') {
      statusColor = Colors.green[50]!;
      statusIcon = Icons.check_circle;
      statusTextColor = Colors.green[700]!;
      displayStatus = 'Approved';
    } else if (displayStatus == 'rejected' ||
        displayStatus.contains('rejected')) {
      statusColor = Colors.red[50]!;
      statusIcon = Icons.cancel;
      statusTextColor = Colors.red[700]!;
      displayStatus = 'Rejected';
    } else if (displayStatus == 'pending' ||
        displayStatus == 'admin_approved') {
      statusColor =
          Colors.orange[50]!; // Light orange for pending/admin_approved
      statusIcon = Icons.access_time; // Clock icon for pending
      statusTextColor = Colors.orange[700]!;
      displayStatus = displayStatus
          .capitalizeFirst!; // Capitalize "Pending" or "Admin_approved"
    } else {
      statusColor = Colors.grey[50]!;
      statusIcon = Icons.info;
      statusTextColor = Colors.grey[700]!;
    }

    final String dateRange =
        '${DateFormat('yyyy-MM-dd').format(leave.startDate)} to ${DateFormat('yyyy-MM-dd').format(leave.endDate)}';
    final String submittedDate = DateFormat(
      'yyyy-MM-dd',
    ).format(leave.createdAt);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFEAEAEA), width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  dateRange,
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
                      displayStatus,
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
                      'Reason: ${leave.reason}',
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
                  // Handle download letter tap - you would need actual file download logic here
                  print('Download Letter tapped for ${leave.id}');
                  Get.snackbar(
                    'Download',
                    'Downloading document for leave ID: ${leave.id}',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.blueGrey.withValues(alpha: 0.8),
                    colorText: Colors.white,
                  );
                },
                icon: const Icon(Icons.download, size: 18),
                label: const Text(
                  'Download Letter',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                  side: BorderSide(color: Colors.grey[400]!),
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

// class LeaveRequestsScreen extends StatefulWidget {
//   const LeaveRequestsScreen({super.key});

//   @override
//   State<LeaveRequestsScreen> createState() => _LeaveRequestsScreenState();
// }

// class _LeaveRequestsScreenState extends State<LeaveRequestsScreen> {
//   int _selectedTab = 0; // 0 for Leave History, 1 for Pending Requests

//   @override
//   Widget build(BuildContext context) {
//     return _buildLeaveRequestsContainer();
//   }

//   Widget _buildLeaveRequestsContainer() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Color(0xFFFEFEFE),
//         borderRadius: BorderRadius.circular(13),
//         border: Border.all(color: Color(0xFFE2E2E3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header Section
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Leave Requests',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black87,
//                 ),
//               ),
//               OutlinedButton.icon(
//                 onPressed: () {
//                   Get.to(() => const ApplyLeaveScreen());
//                 },
//                 icon: const Icon(Icons.add, size: 18),
//                 label: const Text('Apply for Leave'),
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: Colors.grey[700], // Text and icon color
//                   side: BorderSide(color: Colors.grey[400]!), // Border color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),

//           // Segmented Control (Tabs)
//           Container(
//             padding: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: Colors.grey[200], // Background for the segmented control
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: _buildSegmentButton(
//                     label: 'Leave History',
//                     index: 0,
//                     isSelected: _selectedTab == 0,
//                     onTap: () {
//                       setState(() {
//                         _selectedTab = 0;
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: _buildSegmentButton(
//                     label: 'Pending Requests',
//                     index: 1,
//                     isSelected: _selectedTab == 1,
//                     onTap: () {
//                       setState(() {
//                         _selectedTab = 1;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Leave Request List (conditionally rendered based on _selectedTab)
//           if (_selectedTab == 0) // Show Leave History
//             Column(
//               children: [
//                 _buildLeaveRequestCard(
//                   date: '2025-04-10 to 2025-04-12',
//                   reason: 'Medical emergency',
//                   submittedDate: '2025-04-08',
//                   status: 'Approved',
//                 ),
//                 const SizedBox(height: 12),
//                 _buildLeaveRequestCard(
//                   date: '2025-03-20',
//                   reason: 'Personal reasons',
//                   submittedDate: '2025-03-18',
//                   status: 'Rejected',
//                 ),
//                 const SizedBox(height: 12),
//                 // Add more leave request cards here if needed
//               ],
//             )
//           else // Show Pending Requests (Placeholder)
//             const Center(
//               child: Padding(
//                 padding: EdgeInsets.all(24.0),
//                 child: Text(
//                   'No Pending Requests',
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSegmentButton({
//     required String label,
//     required int index,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.white : Colors.transparent,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 10,
//               color: Colors.grey[700],
//               fontWeight: FontWeight.normal,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLeaveRequestCard({
//     required String date,
//     required String reason,
//     required String submittedDate,
//     required String status,
//   }) {
//     Color statusColor;
//     IconData statusIcon;
//     Color statusTextColor;

//     if (status == 'Approved') {
//       statusColor = Colors.green[50]!; // Very light green background
//       statusIcon = Icons.check_circle;
//       statusTextColor = Colors.green[700]!; // Darker green text
//     } else if (status == 'Rejected') {
//       statusColor = Colors.red[50]!; // Very light red background
//       statusIcon = Icons.cancel;
//       statusTextColor = Colors.red[700]!; // Darker red text
//     } else {
//       statusColor = Colors.grey[50]!; // Default for other statuses
//       statusIcon = Icons.info;
//       statusTextColor = Colors.grey[700]!;
//     }

//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Color(0xFFFEFEFE),
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(color: Color(0xFFEAEAEA), width: 1.3),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Text(
//                   date,
//                   style: const TextStyle(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: statusColor,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(statusIcon, size: 10, color: statusTextColor),
//                     const SizedBox(width: 4),
//                     Text(
//                       status,
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w400,
//                         color: statusTextColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Reason: $reason',
//                       style: const TextStyle(fontSize: 8, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Submitted on $submittedDate',
//                       style: const TextStyle(fontSize: 8, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 8),
//               OutlinedButton.icon(
//                 onPressed: () {
//                   // Handle download letter tap
//                   print('Download Letter tapped for $date');
//                 },
//                 icon: const Icon(Icons.download, size: 18),
//                 label: const Text(
//                   'Download Letter',
//                   style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
//                 ),
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: Colors.grey[700], // Text and icon color
//                   side: BorderSide(color: Colors.grey[400]!), // Border color
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
