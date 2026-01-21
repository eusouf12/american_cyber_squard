import 'dart:ui';
import 'package:flutter/material.dart';

class TeachersResourceModel {
  final String fileName;
  final String size;
  final String subject;
  final String date;
  final IconData icon;
  final String type;
  final Color color;

  TeachersResourceModel({
    required this.fileName,
    required this.size,
    required this.subject,
    required this.type,
    required this.date,
    required this.icon,
    required this.color,
  });
}