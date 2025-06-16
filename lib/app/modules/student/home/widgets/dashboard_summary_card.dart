import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';

class DashboardSummaryCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget child;

  const DashboardSummaryCard({
    super.key,
    required this.title,
    this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Color(0xFFE2E2E3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              icon != null
                  ? Icon(icon, size: 18, color: AppColors.primaryBlue)
                  : SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
