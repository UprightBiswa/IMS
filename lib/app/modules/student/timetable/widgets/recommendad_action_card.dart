import 'package:flutter/material.dart';

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
                  "Your attendance forecast is indicating a downward trend. Here's what you can do:\n"
                  "• Attend all Computer Networks classes this month (crucial)\n"
                  "• Don’t miss any more Database Systems lectures\n"
                  "• Meet with your advisor to discuss attendance options",
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
