// import 'package:flutter/material.dart';

// class AttendanceCalendarTab extends StatelessWidget {
//   const AttendanceCalendarTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: const [AttendancePatternsScreen()],
//     );
//   }
// }

// class AttendancePatternsScreen extends StatefulWidget {
//   const AttendancePatternsScreen({super.key});

//   @override
//   State<AttendancePatternsScreen> createState() =>
//       _AttendancePatternsScreenState();
// }

// class _AttendancePatternsScreenState extends State<AttendancePatternsScreen> {
//   int _selectedTab = 0; // 0: Weekly, 1: Monthly, 2: Semester

//   // Data for the Weekly Heatmap
//   final Map<String, List<int>> weeklyAttendanceData = {
//     'Monday': [1, 1, 1, 1, 1], // 1: Present, 0: Late, -1: Leave
//     'Tuesday': [0, 0, 0, 0, 0],
//     'Wednesday': [1, 1, 1, 1, 1],
//     'Thursday': [1, 1, 1, 1, 1],
//     'Friday': [1, 1, 1, 1, 1],
//   };

//   // Define custom colors to match the image
//   static const Color presentColor = Color(0xFF26A69A); // Teal-like green
//   static const Color lateColor = Color(0xFFFFA726); // Orange
//   static const Color leaveColor = Color(0xFFEF5350); // Red

//   // Alert card background colors
//   static const Color physicsAlertBg = Color(0xFFFFEBEE); // Very light red
//   static const Color englishAlertBg = Color(0xFFFFF8E1); // Very light orange
//   static const Color upcomingEvaluationBg = Color(
//     0xFFE3F2FD,
//   ); // Very light blue

//   // Alert card text colors (darker shades of their background colors)
//   static const Color physicsAlertText = Color(0xFFD32F2F); // Darker red
//   static const Color englishAlertText = Color(0xFFF57F17); // Darker orange
//   static const Color upcomingEvaluationText = Color(0xFF1976D2); // Darker blue

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Main Title and Subtitle
//         const Text(
//           'Attendance Patterns',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           'Visualize Your Attendance Trends',
//           style: TextStyle(fontSize: 15, color: Colors.grey[600]),
//         ),
//         const SizedBox(height: 24),

//         // Segmented Control (Weekly, Monthly, Semester)
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[200], // Background for the segmented control
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Weekly',
//                   index: 0,
//                   isSelected: _selectedTab == 0,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 0;
//                     });
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Monthly',
//                   index: 1,
//                   isSelected: _selectedTab == 1,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 1;
//                     });
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Semester',
//                   index: 2,
//                   isSelected: _selectedTab == 2,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 2;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 24),

//         // Weekly Heatmap Card (conditionally shown based on _selectedTab)
//         if (_selectedTab == 0) _buildWeeklyHeatmapCard(),
//         const SizedBox(height: 24),

//         // Physics Alert Card
//         _buildAlertCard(
//           backgroundColor: physicsAlertBg,
//           iconColor: physicsAlertText,
//           title: 'Physics Alert',
//           description:
//               'Your attendance is below 75%. You need to attend at least 4 more classes to meet the minimum requirement.',
//           actionText: 'View Schedule',
//           onActionTap: () {
//             print('View Schedule tapped for Physics');
//           },
//         ),
//         const SizedBox(height: 12),

//         // English Alert Card
//         _buildAlertCard(
//           backgroundColor: englishAlertBg,
//           iconColor: englishAlertText,
//           title: 'English Alert',
//           description:
//               'Your attendance is currently at 80%. Attend 2 more classes to reach 85%.',
//           actionText: 'Contact Faculty',
//           onActionTap: () {
//             print('Contact Faculty tapped for English');
//           },
//         ),
//         const SizedBox(height: 12),

//         // Upcoming Evaluation Card
//         _buildAlertCard(
//           backgroundColor: upcomingEvaluationBg,
//           iconColor: upcomingEvaluationText,
//           title: 'Upcoming Evaluation',
//           description:
//               'Mid-term evaluations are scheduled next week. Ensure your attendance is above the required threshold.',
//           actionText: null, // No action button for this one
//           onActionTap: null,
//         ),
//         const SizedBox(height: 24),

//         // Download Attendance Report Button
//         Center(
//           child: OutlinedButton.icon(
//             onPressed: () {
//               print('Download Attendance Report tapped');
//             },
//             icon: const Icon(Icons.download, size: 20),
//             label: const Text('Download Attendance Report'),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: Colors.grey[700],
//               side: BorderSide(color: Colors.grey[400]!),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16), // Bottom padding
//       ],
//     );
//   }

//   // Helper widget for segmented control buttons
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
//               color: isSelected ? Colors.black87 : Colors.grey[700],
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper widget for the Weekly Heatmap Card
//   Widget _buildWeeklyHeatmapCard() {
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
//           const Text(
//             'Weekly Heatmap',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'May 13 - 17, 2025',
//             style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//           ),
//           const SizedBox(height: 20),
//           Column(
//             children: weeklyAttendanceData.entries.map((entry) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 6.0),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 70, // Fixed width for day labels
//                       child: Text(
//                         entry.key,
//                         style: TextStyle(fontSize: 13, color: Colors.grey[700]),
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: entry.value.map((status) {
//                           Color color;
//                           if (status == 1) {
//                             color = presentColor;
//                           } else if (status == 0) {
//                             color = lateColor;
//                           } else {
//                             color = leaveColor;
//                           }
//                           return Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 2.0,
//                               ),
//                               child: Container(
//                                 height: 20, // Height of the bar segments
//                                 decoration: BoxDecoration(
//                                   color: color,
//                                   borderRadius: BorderRadius.circular(
//                                     4,
//                                   ), // Slightly rounded corners for segments
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//           const SizedBox(height: 20),
//           // Legend
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildLegendItem('Present', presentColor),
//               _buildLegendItem('Late', lateColor),
//               _buildLegendItem('Leave', leaveColor),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper widget for legend items
//   Widget _buildLegendItem(String text, Color color) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//         ),
//         const SizedBox(width: 6),
//         Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
//       ],
//     );
//   }

//   // Helper widget for Alert/Information Cards
//   Widget _buildAlertCard({
//     required Color backgroundColor,
//     required Color iconColor,
//     required String title,
//     required String description,
//     String? actionText,
//     VoidCallback? onActionTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(left: BorderSide(color: iconColor, width: 4)),
//         borderRadius: BorderRadius.circular(8),
//         color: backgroundColor,
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.info_outline, // Use info_outline as per image
//                 color: iconColor,
//                 size: 20,
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: iconColor, // Title color matches icon
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       description,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey[700], // Darker grey for description
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           if (actionText != null && onActionTap != null) ...[
//             const SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: GestureDetector(
//                 onTap: onActionTap,
//                 child: Text(
//                   actionText,
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import Get for potential GetX controllers later if needed

// class AttendanceCalendarTab extends StatelessWidget {
//   const AttendanceCalendarTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // It's better to directly return the screen widget if it fills the tab content
//     return const AttendancePatternsScreen();
//   }
// }

// class AttendancePatternsScreen extends StatefulWidget {
//   const AttendancePatternsScreen({super.key});

//   @override
//   State<AttendancePatternsScreen> createState() =>
//       _AttendancePatternsScreenState();
// }

// class _AttendancePatternsScreenState extends State<AttendancePatternsScreen> {
//   int _selectedTab = 0; // 0: Weekly, 1: Monthly, 2: Semester

//   // Data for the Weekly Heatmap - This should ideally come from a controller/API
//   final Map<String, List<int>> weeklyAttendanceData = {
//     'Mon': [1, 1, 1, 1, 1], // 1: Present, 0: Late, -1: Leave
//     'Tue': [1, 1, 1, 1, 1],
//     'Wed': [1, 0, 1, 1, 1], // Example: one late day
//     'Thu': [1, 1, 1, 1, 1],
//     'Fri': [1, 1, 1, 1, 1],
//     'Sat': [1, 1, 1, 1, 1],
//   };

//   // Define custom colors to match the Figma image
//   static const Color presentColor = Color(0xFF5DD672); // Green from Figma
//   static const Color lateColor = Color(0xFFFFB039); // Orange from Figma
//   static const Color leaveColor = Color(0xFFF96666); // Red from Figma

//   // Alert card background colors and border colors matching Figma
//   static const Color physicsAlertBg = Color(0xFFFFF1F1); // Light red
//   static const Color physicsAlertBorder = Color(0xFFF96666); // Red border
//   static const Color englishAlertBg = Color(0xFFFFF8EE); // Light orange
//   static const Color englishAlertBorder = Color(0xFFFFB039); // Orange border
//   static const Color upcomingEvaluationBg = Color(0xFFEEF7FF); // Light blue
//   static const Color upcomingEvaluationBorder = Color(0xFF67B5FF); // Blue border

//   // Alert card text colors (darker shades of their border colors from Figma)
//   static const Color physicsAlertText = Color(0xFFD83030); // Darker red
//   static const Color englishAlertText = Color(0xFFD37D00); // Darker orange
//   static const Color upcomingEvaluationText = Color(0xFF338FFF); // Darker blue

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0), // Overall padding
//       children: [
//         // Main Title and Subtitle
//         const Text(
//           'Attendance Patterns',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF333333), // Dark text color
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           'Visualize Your Attendance Trends',
//           style: TextStyle(fontSize: 15, color: Colors.grey[600]),
//         ),
//         const SizedBox(height: 24),

//         // Segmented Control (Weekly, Monthly, Semester)
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white, // White background for the segmented control
//             borderRadius: BorderRadius.circular(10.0), // Rounded corners
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Weekly',
//                   index: 0,
//                   isSelected: _selectedTab == 0,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 0;
//                     });
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Monthly',
//                   index: 1,
//                   isSelected: _selectedTab == 1,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 1;
//                     });
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Semester',
//                   index: 2,
//                   isSelected: _selectedTab == 2,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 2;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 24),

//         // Weekly Heatmap Card (conditionally shown based on _selectedTab)
//         if (_selectedTab == 0) _buildWeeklyHeatmapCard(),
//         const SizedBox(height: 24),

//         // Physics Alert Card
//         _buildAlertCard(
//           backgroundColor: physicsAlertBg,
//           borderColor: physicsAlertBorder,
//           iconColor: physicsAlertBorder, // Icon color matches border
//           titleColor: physicsAlertText, // Title color matches text
//           title: 'Physics Alert',
//           description:
//               'Your attendance is below 75%. You need to attend at least 4 more classes to meet the minimum requirement.',
//           actionText: 'View Schedule',
//           onActionTap: () {
//             print('View Schedule tapped for Physics');
//           },
//         ),
//         const SizedBox(height: 12),

//         // English Alert Card
//         _buildAlertCard(
//           backgroundColor: englishAlertBg,
//           borderColor: englishAlertBorder,
//           iconColor: englishAlertBorder,
//           titleColor: englishAlertText,
//           title: 'English Alert',
//           description:
//               'Your attendance is currently at 80%. Attend 2 more classes to reach 85%.',
//           actionText: 'View Schedule', // Changed to View Schedule as per Figma
//           onActionTap: () {
//             print('Contact Faculty tapped for English');
//           },
//         ),
//         const SizedBox(height: 12),

//         // Upcoming Evaluation Card
//         _buildAlertCard(
//           backgroundColor: upcomingEvaluationBg,
//           borderColor: upcomingEvaluationBorder,
//           iconColor: upcomingEvaluationBorder,
//           titleColor: upcomingEvaluationText,
//           title: 'Upcoming Evaluation',
//           description:
//               'Mid-term evaluations are scheduled next week. Ensure your attendance is above the required threshold.',
//           actionText: null, // No action button for this one
//           onActionTap: null,
//         ),
//         const SizedBox(height: 24),

//         // Download Attendance Report Button
//         Center(
//           child: ElevatedButton.icon( // Changed to ElevatedButton as per Figma
//             onPressed: () {
//               print('Download Attendance Report tapped');
//             },
//             icon: const Icon(Icons.download, size: 20, color: Colors.white), // White icon
//             label: const Text(
//               'Download Attendance Report',
//               style: TextStyle(color: Colors.white, fontSize: 16), // White text
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF67B5FF), // Blue background from Figma
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0), // More rounded corners
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//               elevation: 3, // Add some shadow
//             ),
//           ),
//         ),
//         const SizedBox(height: 16), // Bottom padding
//       ],
//     );
//   }

//   // Helper widget for segmented control buttons
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
//           color: isSelected ? const Color(0xFFE8F2FF) : Colors.transparent, // Selected state background
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? const Color(0xFF333333) : Colors.grey[700],
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper widget for the Weekly Heatmap Card
//   Widget _buildWeeklyHeatmapCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white, // White background for the card
//         borderRadius: BorderRadius.circular(12), // Slightly more rounded
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Weekly Heatmap',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF333333),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'May 13 - 17, 2025',
//             style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start, // Align top for text and bars
//             children: [
//               // Day Labels Column
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
//                 children: weeklyAttendanceData.keys.map((day) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.5), // Adjust padding to align with bars
//                     child: SizedBox(
//                       height: 20, // Match bar height
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           day,
//                           style: TextStyle(fontSize: 13, color: Colors.grey[700]),
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(width: 10), // Space between day labels and bars

//               // Heatmap Bars Column
//               Expanded(
//                 child: Column(
//                   children: weeklyAttendanceData.entries.map((entry) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4.0), // Vertical spacing between rows
//                       child: Row(
//                         children: entry.value.map((status) {
//                           Color color;
//                           if (status == 1) {
//                             color = presentColor;
//                           } else if (status == 0) {
//                             color = lateColor;
//                           } else {
//                             color = leaveColor;
//                           }
//                           return Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 2.0, // Space between segments
//                               ),
//                               child: Container(
//                                 height: 20, // Height of the bar segments
//                                 decoration: BoxDecoration(
//                                   color: color,
//                                   borderRadius: BorderRadius.circular(
//                                     4,
//                                   ), // Slightly rounded corners for segments
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           // Legend
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildLegendItem('Present', presentColor),
//               _buildLegendItem('Late', lateColor),
//               _buildLegendItem('Leave', leaveColor),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper widget for legend items
//   Widget _buildLegendItem(String text, Color color) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//         ),
//         const SizedBox(width: 6),
//         Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
//       ],
//     );
//   }

//   // Helper widget for Alert/Information Cards (updated to match Figma)
//   Widget _buildAlertCard({
//     required Color backgroundColor,
//     required Color borderColor,
//     required Color iconColor,
//     required Color titleColor,
//     required String title,
//     required String description,
//     String? actionText,
//     VoidCallback? onActionTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(left: BorderSide(color: borderColor, width: 4)), // Left border from Figma
//         borderRadius: BorderRadius.circular(8),
//         color: backgroundColor,
//         boxShadow: [ // Add subtle shadow as per Figma
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.05),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.info_outline, // Use info_outline as per Figma
//                 color: iconColor,
//                 size: 20,
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: titleColor, // Title color matches Figma
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       description,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey[700], // Darker grey for description
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           if (actionText != null && onActionTap != null) ...[
//             const SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: GestureDetector(
//                 onTap: onActionTap,
//                 child: Text(
//                   actionText,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: borderColor, // Action text color matches border color
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Still good to have if you plan to integrate GetX controllers later

// class AttendanceCalendarTab extends StatelessWidget {
//   const AttendanceCalendarTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const AttendancePatternsScreen();
//   }
// }

// class AttendancePatternsScreen extends StatefulWidget {
//   const AttendancePatternsScreen({super.key});

//   @override
//   State<AttendancePatternsScreen> createState() =>
//       _AttendancePatternsScreenState();
// }

// class _AttendancePatternsScreenState extends State<AttendancePatternsScreen> {
//   int _selectedTab = 0; // 0: Weekly, 1: Monthly, 2: Semester

//   // Data for the Weekly Heatmap - This should ideally come from a controller/API
//   // I've adjusted the data to include a 'Late' entry for "Wednesday"
//   final Map<String, List<int>> weeklyAttendanceData = {
//     'Mon': [1, 1, 1, 1, 1], // 1: Present, 0: Late, -1: Leave
//     'Tue': [1, 1, 1, 1, 1],
//     'Wed': [1, 0, 1, 1, 1], // Example: one late day to match Figma
//     'Thu': [1, 1, 1, 1, 1],
//     'Fri': [1, 1, 1, 1, 1],
//     'Sat': [1, 1, 1, 1, 1], // Saturday also present in Figma
//   };

//   // Define custom colors directly from Figma "Attendance Calender.png"
//   static const Color presentColor = Color(0xFF5DD672); // Green from Figma
//   static const Color lateColor = Color(0xFFFFB039); // Orange from Figma
//   static const Color leaveColor = Color(0xFFF96666); // Red from Figma

//   // Alert card background colors and border colors matching Figma "Attendance Calender.png"
//   static const Color physicsAlertBg = Color(0xFFFFF1F1); // Light red
//   static const Color physicsAlertBorder = Color(0xFFF96666); // Red border
//   static const Color englishAlertBg = Color(0xFFFFF8EE); // Light orange
//   static const Color englishAlertBorder = Color(0xFFFFB039); // Orange border
//   static const Color upcomingEvaluationBg = Color(0xFFEEF7FF); // Light blue
//   static const Color upcomingEvaluationBorder = Color(0xFF67B5FF); // Blue border

//   // Alert card text colors (darker shades of their border colors from Figma)
//   static const Color physicsAlertText = Color(0xFFD83030); // Darker red
//   static const Color englishAlertText = Color(0xFFD37D00); // Darker orange
//   static const Color upcomingEvaluationText = Color(0xFF338FFF); // Darker blue

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//       children: [
//         // Main Title and Subtitle
//         const Text(
//           'Attendance Patterns',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           'Visualize Your Attendance Trends',
//           style: TextStyle(fontSize: 15, color: Colors.grey[600]),
//         ),
//         const SizedBox(height: 24),

//         // Segmented Control (Weekly, Monthly, Semester)
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Weekly',
//                   index: 0,
//                   isSelected: _selectedTab == 0,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 0;
//                     });
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Monthly',
//                   index: 1,
//                   isSelected: _selectedTab == 1,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 1;
//                     });
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: _buildSegmentButton(
//                   label: 'Semester',
//                   index: 2,
//                   isSelected: _selectedTab == 2,
//                   onTap: () {
//                     setState(() {
//                       _selectedTab = 2;
//                     });
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 24),

//         // Weekly Heatmap Card (conditionally shown based on _selectedTab)
//         if (_selectedTab == 0) _buildWeeklyHeatmapCard(),
//         const SizedBox(height: 24),

//         // Physics Alert Card
//         _buildAlertCard(
//           icon: Icons.error_outline, // Changed to error_outline as per Figma image
//           backgroundColor: physicsAlertBg,
//           borderColor: physicsAlertBorder,
//           iconColor: physicsAlertBorder,
//           titleColor: physicsAlertText,
//           title: 'Physics Alert',
//           description:
//               'Your attendance is below 75%. You need to attend at least 4 more classes to meet the minimum requirement.',
//           actionText: 'View Schedule',
//           onActionTap: () {
//             print('View Schedule tapped for Physics');
//           },
//         ),
//         const SizedBox(height: 12),

//         // English Alert Card
//         _buildAlertCard(
//           icon: Icons.error_outline, // Changed to error_outline as per Figma image
//           backgroundColor: englishAlertBg,
//           borderColor: englishAlertBorder,
//           iconColor: englishAlertBorder,
//           titleColor: englishAlertText,
//           title: 'English Alert',
//           description:
//               'Your attendance is currently at 80%. Attend 2 more classes to reach 85%.',
//           actionText: 'View Schedule', // Confirmed from Figma
//           onActionTap: () {
//             print('View Schedule tapped for English');
//           },
//         ),
//         const SizedBox(height: 12),

//         // Upcoming Evaluation Card
//         _buildAlertCard(
//           icon: Icons.info_outline, // Confirmed info_outline for this one in Figma
//           backgroundColor: upcomingEvaluationBg,
//           borderColor: upcomingEvaluationBorder,
//           iconColor: upcomingEvaluationBorder,
//           titleColor: upcomingEvaluationText,
//           title: 'Upcoming Evaluation',
//           description:
//               'Mid-term evaluations are scheduled next week. Ensure your attendance is above the required threshold.',
//           actionText: null, // No action button for this one
//           onActionTap: null,
//         ),
//         const SizedBox(height: 24),

//         // Download Attendance Report Button
//         Center(
//           child: ElevatedButton.icon(
//             onPressed: () {
//               print('Download Attendance Report tapped');
//             },
//             icon: const Icon(Icons.download, size: 20, color: Colors.white),
//             label: const Text(
//               'Download Attendance Report',
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF67B5FF),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//               elevation: 3,
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//       ],
//     );
//   }

//   // Helper widget for segmented control buttons (no changes needed, seems accurate)
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
//           color: isSelected ? const Color(0xFFE8F2FF) : Colors.transparent,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? const Color(0xFF333333) : Colors.grey[700],
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper widget for the Weekly Heatmap Card (Re-designed to match Figma's exact graph layout)
//   Widget _buildWeeklyHeatmapCard() {
//     // Determine the max number of bars for a day to correctly size the graph area
//     int maxBars = 0;
//     for (var dataList in weeklyAttendanceData.values) {
//       if (dataList.length > maxBars) {
//         maxBars = dataList.length;
//       }
//     }

//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 16), // Adjust padding as per Figma
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Weekly Heatmap',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF333333),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'May 13 - 17, 2025',
//             style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//           ),
//           const SizedBox(height: 20),
//           // Heatmap grid (Day labels on left, bars on right)
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start, // Align to top
//             children: [
//               // Day Labels
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
//                 children: weeklyAttendanceData.keys.map((day) {
//                   return Container(
//                     height: 30, // Height of each row (bar + padding)
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       day,
//                       style: TextStyle(fontSize: 13, color: Colors.grey[700]),
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(width: 10), // Space between day labels and bars

//               // Heatmap Bars
//               Expanded(
//                 child: Column(
//                   children: weeklyAttendanceData.entries.map((entry) {
//                     return Container(
//                       height: 30, // Fixed height for each row
//                       alignment: Alignment.centerLeft, // Align bars to the left
//                       child: Row(
//                         children: List.generate(maxBars, (index) { // Ensure all days have the same number of "slots"
//                           int? status = index < entry.value.length ? entry.value[index] : null;

//                           Color color;
//                           if (status == 1) {
//                             color = presentColor;
//                           } else if (status == 0) {
//                             color = lateColor;
//                           } else if (status == -1) {
//                             color = leaveColor;
//                           } else {
//                             // If data is null (no attendance for this slot), show a lighter grey bar
//                             color = Colors.grey.shade200;
//                           }
//                           return Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 2.0, // Space between segments
//                               ),
//                               child: Container(
//                                 height: 20, // Height of the actual bar segment
//                                 decoration: BoxDecoration(
//                                   color: color,
//                                   borderRadius: BorderRadius.circular(4), // Rounded corners
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           // Legend
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildLegendItem('Present', presentColor),
//               _buildLegendItem('Late', lateColor),
//               _buildLegendItem('Leave', leaveColor),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper widget for legend items (no changes needed)
//   Widget _buildLegendItem(String text, Color color) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//         ),
//         const SizedBox(width: 6),
//         Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
//       ],
//     );
//   }

//   // Helper widget for Alert/Information Cards (updated to match Figma)
//   Widget _buildAlertCard({
//     required IconData icon, // Now accepts an IconData
//     required Color backgroundColor,
//     required Color borderColor,
//     required Color iconColor,
//     required Color titleColor,
//     required String title,
//     required String description,
//     String? actionText,
//     VoidCallback? onActionTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(left: BorderSide(color: borderColor, width: 4)),
//         borderRadius: BorderRadius.circular(8),
//         color: backgroundColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.05),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 icon, // Use the provided icon
//                 color: iconColor,
//                 size: 20,
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: titleColor,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       description,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           if (actionText != null && onActionTap != null) ...[
//             const SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: GestureDetector(
//                 onTap: onActionTap,
//                 child: Text(
//                   actionText,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: borderColor, // Action text color matches border color
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
class AttendanceCalendarTab extends StatelessWidget {
  const AttendanceCalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendancePatternsScreen();
  }
}

class AttendancePatternsScreen extends StatefulWidget {
  const AttendancePatternsScreen({super.key});

  @override
  State<AttendancePatternsScreen> createState() =>
      _AttendancePatternsScreenState();
}

class _AttendancePatternsScreenState extends State<AttendancePatternsScreen> {
  int _selectedTab = 0;

  final Map<String, List<int>> weeklyAttendanceData = {
    'Mon': [1, 1, 1, 1, 1],
    'Tue': [1, 1, 1, 1, 1],
    'Wed': [1, 0, 1, 1, 1],
    'Thu': [1, 1, 1, 1, 1],
    'Fri': [1, 1, 1, 1, 1],
    'Sat': [1, 1, 1, 1, 1],
  };

  static const Color presentColor = Color(0xFF5DD672);
  static const Color lateColor = Color(0xFFFFB039);
  static const Color leaveColor = Color(0xFFF96666);

  static const Color physicsAlertBg = Color(0xFFFFF1F1);
  static const Color physicsAlertBorder = Color(0xFFF96666);
  static const Color englishAlertBg = Color(0xFFFFF8EE);
  static const Color englishAlertBorder = Color(0xFFFFB039);
  static const Color upcomingEvaluationBg = Color(0xFFEEF7FF);
  static const Color upcomingEvaluationBorder = Color(0xFF67B5FF);

  static const Color physicsAlertText = Color(0xFFD83030);
  static const Color englishAlertText = Color(0xFFD37D00);
  static const Color upcomingEvaluationText = Color(0xFF338FFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            const Text(
              'Attendance Patterns',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Visualize Your Attendance Trends',
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            _buildSegmentControl(),
            const SizedBox(height: 24),
            if (_selectedTab == 0) _buildWeeklyHeatmapCard(),
            const SizedBox(height: 24),
            _buildAlertCard(
              icon: Icons.error_outline,
              backgroundColor: physicsAlertBg,
              borderColor: physicsAlertBorder,
              iconColor: physicsAlertBorder,
              titleColor: physicsAlertText,
              title: 'Physics Alert',
              description:
                  'Your attendance is below 75%. You need to attend at least 4 more classes.',
              actionText: 'View Schedule',
              onActionTap: () {},
            ),
            const SizedBox(height: 12),
            _buildAlertCard(
              icon: Icons.error_outline,
              backgroundColor: englishAlertBg,
              borderColor: englishAlertBorder,
              iconColor: englishAlertBorder,
              titleColor: englishAlertText,
              title: 'English Alert',
              description:
                  'Your attendance is currently at 80%. Attend 2 more classes to reach 85%.',
              actionText: 'View Schedule',
              onActionTap: () {},
            ),
            const SizedBox(height: 12),
            _buildAlertCard(
              icon: Icons.info_outline,
              backgroundColor: upcomingEvaluationBg,
              borderColor: upcomingEvaluationBorder,
              iconColor: upcomingEvaluationBorder,
              titleColor: upcomingEvaluationText,
              title: 'Upcoming Evaluation',
              description:
                  'Mid-term evaluations are next week. Ensure your attendance is sufficient.',
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, color: Colors.white, size: 20),
                label: const Text(
                  'Download Attendance Report',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF67B5FF),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentControl() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final labels = ['Weekly', 'Monthly', 'Semester'];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: _selectedTab == index
                      ? const Color(0xFFE8F2FF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: _selectedTab == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _selectedTab == index
                          ? const Color(0xFF333333)
                          : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWeeklyHeatmapCard() {
    final int maxBars = weeklyAttendanceData.values
        .map((e) => e.length)
        .reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Heatmap',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'May 13 - 17, 2025',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: weeklyAttendanceData.keys
                    .map(
                      (day) => SizedBox(
                        height: 30,
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: weeklyAttendanceData.entries.map((entry) {
                    return SizedBox(
                      height: 30,
                      child: Row(
                        children: List.generate(maxBars, (index) {
                          final int? status = index < entry.value.length
                              ? entry.value[index]
                              : null;
                          final Color color = status == 1
                              ? presentColor
                              : status == 0
                              ? lateColor
                              : status == -1
                              ? leaveColor
                              : Colors.grey.shade200;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2.0,
                              ),
                              child: Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem('Present', presentColor),
              _buildLegendItem('Late', lateColor),
              _buildLegendItem('Leave', leaveColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildAlertCard({
    required IconData icon,
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
    required Color titleColor,
    required String title,
    required String description,
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: borderColor, width: 4)),
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (actionText != null && onActionTap != null) ...[
            const SizedBox(height: 12),
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: borderColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
