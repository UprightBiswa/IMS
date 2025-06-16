import 'package:flutter/material.dart';

class SummaryCardModel {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final double? progressValue; // optional

  SummaryCardModel({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    this.progressValue,
  });
}
