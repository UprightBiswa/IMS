import 'package:flutter/material.dart';

class TodayClassModel {
  final String subject;
  final String professor;
  final String time;
  final String status;
  final Color color;

  TodayClassModel({
    required this.subject,
    required this.professor,
    required this.time,
    required this.status,

    required this.color,
  });

  factory TodayClassModel.fromJson(Map<String, dynamic> json) {
    return TodayClassModel(
      subject: json['subject'],
      professor: json['professor'],
      time: json['time'],
      status: json['status'] ?? 'Online',
      color: Color(int.parse(json['color'])),
    );
  }
}
