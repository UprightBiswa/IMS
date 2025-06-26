import 'package:flutter/material.dart';

class AttendanceCalendarTab extends StatelessWidget {
  const AttendanceCalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [AttendancePatternsScreen()],
    );
  }
}

class AttendancePatternsScreen extends StatefulWidget {
  const AttendancePatternsScreen({super.key});

  @override
  State<AttendancePatternsScreen> createState() =>
      _AttendancePatternsScreenState();
}

class _AttendancePatternsScreenState extends State<AttendancePatternsScreen> {
  int _selectedTab = 0; // 0: Weekly, 1: Monthly, 2: Semester

  // Data for the Weekly Heatmap
  final Map<String, List<int>> weeklyAttendanceData = {
    'Monday': [1, 1, 1, 1, 1], // 1: Present, 0: Late, -1: Leave
    'Tuesday': [0, 0, 0, 0, 0],
    'Wednesday': [1, 1, 1, 1, 1],
    'Thursday': [1, 1, 1, 1, 1],
    'Friday': [1, 1, 1, 1, 1],
  };

  // Define custom colors to match the image
  static const Color presentColor = Color(0xFF26A69A); // Teal-like green
  static const Color lateColor = Color(0xFFFFA726); // Orange
  static const Color leaveColor = Color(0xFFEF5350); // Red

  // Alert card background colors
  static const Color physicsAlertBg = Color(0xFFFFEBEE); // Very light red
  static const Color englishAlertBg = Color(0xFFFFF8E1); // Very light orange
  static const Color upcomingEvaluationBg = Color(
    0xFFE3F2FD,
  ); // Very light blue

  // Alert card text colors (darker shades of their background colors)
  static const Color physicsAlertText = Color(0xFFD32F2F); // Darker red
  static const Color englishAlertText = Color(0xFFF57F17); // Darker orange
  static const Color upcomingEvaluationText = Color(0xFF1976D2); // Darker blue

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Title and Subtitle
        const Text(
          'Attendance Patterns',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Visualize Your Attendance Trends',
          style: TextStyle(fontSize: 15, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        // Segmented Control (Weekly, Monthly, Semester)
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background for the segmented control
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildSegmentButton(
                  label: 'Weekly',
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
                  label: 'Monthly',
                  index: 1,
                  isSelected: _selectedTab == 1,
                  onTap: () {
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                ),
              ),
              Expanded(
                child: _buildSegmentButton(
                  label: 'Semester',
                  index: 2,
                  isSelected: _selectedTab == 2,
                  onTap: () {
                    setState(() {
                      _selectedTab = 2;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Weekly Heatmap Card (conditionally shown based on _selectedTab)
        if (_selectedTab == 0) _buildWeeklyHeatmapCard(),
        const SizedBox(height: 24),

        // Physics Alert Card
        _buildAlertCard(
          backgroundColor: physicsAlertBg,
          iconColor: physicsAlertText,
          title: 'Physics Alert',
          description:
              'Your attendance is below 75%. You need to attend at least 4 more classes to meet the minimum requirement.',
          actionText: 'View Schedule',
          onActionTap: () {
            print('View Schedule tapped for Physics');
          },
        ),
        const SizedBox(height: 12),

        // English Alert Card
        _buildAlertCard(
          backgroundColor: englishAlertBg,
          iconColor: englishAlertText,
          title: 'English Alert',
          description:
              'Your attendance is currently at 80%. Attend 2 more classes to reach 85%.',
          actionText: 'Contact Faculty',
          onActionTap: () {
            print('Contact Faculty tapped for English');
          },
        ),
        const SizedBox(height: 12),

        // Upcoming Evaluation Card
        _buildAlertCard(
          backgroundColor: upcomingEvaluationBg,
          iconColor: upcomingEvaluationText,
          title: 'Upcoming Evaluation',
          description:
              'Mid-term evaluations are scheduled next week. Ensure your attendance is above the required threshold.',
          actionText: null, // No action button for this one
          onActionTap: null,
        ),
        const SizedBox(height: 24),

        // Download Attendance Report Button
        Center(
          child: OutlinedButton.icon(
            onPressed: () {
              print('Download Attendance Report tapped');
            },
            icon: const Icon(Icons.download, size: 20),
            label: const Text('Download Attendance Report'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey[700],
              side: BorderSide(color: Colors.grey[400]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 16), // Bottom padding
      ],
    );
  }

  // Helper widget for segmented control buttons
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
              color: isSelected ? Colors.black87 : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for the Weekly Heatmap Card
  Widget _buildWeeklyHeatmapCard() {
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
          const Text(
            'Weekly Heatmap',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'May 13 - 17, 2025',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Column(
            children: weeklyAttendanceData.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70, // Fixed width for day labels
                      child: Text(
                        entry.key,
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: entry.value.map((status) {
                          Color color;
                          if (status == 1) {
                            color = presentColor;
                          } else if (status == 0) {
                            color = lateColor;
                          } else {
                            color = leaveColor;
                          }
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2.0,
                              ),
                              child: Container(
                                height: 20, // Height of the bar segments
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(
                                    4,
                                  ), // Slightly rounded corners for segments
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // Legend
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

  // Helper widget for legend items
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

  // Helper widget for Alert/Information Cards
  Widget _buildAlertCard({
    required Color backgroundColor,
    required Color iconColor,
    required String title,
    required String description,
    String? actionText,
    VoidCallback? onActionTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: iconColor, width: 4)),
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline, // Use info_outline as per image
                color: iconColor,
                size: 20,
              ),
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
                        color: iconColor, // Title color matches icon
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700], // Darker grey for description
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (actionText != null && onActionTap != null) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: onActionTap,
                child: Text(
                  actionText,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
