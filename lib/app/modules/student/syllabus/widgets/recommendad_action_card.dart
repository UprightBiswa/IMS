import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart' show AppColors;

class RecommendedActionsCard extends StatelessWidget {
  const RecommendedActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Color(0xFFFFB300), width: 4)),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFFEFBEA),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xFFFFB300), size: 20),
          SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Actions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 8),
                Text(
                  "Your progress forecast is indicating a downward trend. Here's what you can do:\n",
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
                _buildBulletPoint(
                  'Focus on English Literature - complete Chapters 6-8 by Friday.',
                ),
                _buildBulletPoint(
                  'Complete your remaining research report on Data Structures.',
                ),
                _buildBulletPoint(
                  'Meet with your advisor to discuss study strategies.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 6, color: AppColors.darkText),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
