import 'package:flutter/material.dart';

class MoodPrescription {
  final int id;
  final String moodName;
  final IconData icon;
  final Color color;
  final String verseText;
  final String verseSource;
  final String dua;
  final String action;

  const MoodPrescription({
    required this.id,
    required this.moodName,
    required this.icon,
    required this.color,
    required this.verseText,
    required this.verseSource,
    required this.dua,
    required this.action,
  });
}
