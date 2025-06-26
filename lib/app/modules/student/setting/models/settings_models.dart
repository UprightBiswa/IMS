import 'package:flutter/material.dart';

class PerformanceMetric {
  final String title;
  final String progressDescription;
  final PerformanceStatus status;

  PerformanceMetric({
    required this.title,
    required this.progressDescription,
    required this.status,
  });

  static List<PerformanceMetric> dummyList() {
    return [
      PerformanceMetric(
        title: 'Data Structures',
        progressDescription: '19/20 chapters completed',
        status: PerformanceStatus.excellent,
      ),
      PerformanceMetric(
        title: 'Database Management',
        progressDescription: '14/16 chapters completed',
        status: PerformanceStatus.good,
      ),
      PerformanceMetric(
        title: 'Computer Networks',
        progressDescription: '6/12 chapters completed',
        status: PerformanceStatus.inProgress,
      ),
      PerformanceMetric(
        title: 'English Literature',
        progressDescription: '5/14 chapters completed',
        status: PerformanceStatus.behind,
      ),
    ];
  }
}

enum PerformanceStatus { excellent, good, inProgress, behind }

class SettingItem {
  final IconData icon;
  final String title;
  final String? subtitle; // Optional subtitle for description
  final SettingType type;
  final bool? initialToggleValue; // For toggle switches

  SettingItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.type,
    this.initialToggleValue,
  });
}

enum SettingType { toggle, navigation }
