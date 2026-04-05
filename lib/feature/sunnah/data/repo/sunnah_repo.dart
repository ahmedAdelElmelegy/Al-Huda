import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import '../model/sunnah_habit.dart';

abstract class SunnahRepo {
  Future<List<SunnahHabit>> getSunnahHabits();
  Future<void> toggleHabitCompletion(String habitId);
}

class SunnahRepoImpl implements SunnahRepo {
  static const String habitBoxName = 'sunnah_habits_box';
  
  @override
  Future<List<SunnahHabit>> getSunnahHabits() async {
    final String response = await rootBundle.loadString('assets/data/sunnah_habits.json');
    final List<dynamic> data = json.decode(response);
    final box = await Hive.openBox(habitBoxName);
    
    String today = DateTime.now().toIso8601String().split('T')[0];

    return data.map((item) {
      final habitId = item['id'];
      final savedData = box.get(habitId);
      
      bool isCompleted = false;
      if (savedData != null) {
        isCompleted = savedData['lastCompletedDate'] == today;
      }

      return SunnahHabit.fromJson({
        ...item,
        'isCompleted': isCompleted,
        'streak': savedData?['streak'] ?? 0,
        'lastCompletedDate': savedData?['lastCompletedDate'],
      });
    }).toList();
  }

  @override
  Future<void> toggleHabitCompletion(String habitId) async {
    final box = await Hive.openBox(habitBoxName);
    final savedData = box.get(habitId) ?? {
      'streak': 0,
      'lastCompletedDate': null,
    };

    String today = DateTime.now().toIso8601String().split('T')[0];
    bool isCurrentlyCompletedToday = savedData['lastCompletedDate'] == today;
    
    int newStreak = savedData['streak'] ?? 0;
    String? newLastDate = savedData['lastCompletedDate'];

    if (!isCurrentlyCompletedToday) {
      if (newLastDate != null) {
        DateTime last = DateTime.parse(newLastDate);
        DateTime now = DateTime.now();
        int diff = DateTime(now.year, now.month, now.day).difference(DateTime(last.year, last.month, last.day)).inDays;
        
        if (diff == 1) {
          newStreak++;
        } else if (diff > 1) {
          newStreak = 1;
        }
      } else {
        newStreak = 1;
      }
      newLastDate = today;
    } else {
      newLastDate = null;
      if (newStreak > 0) newStreak--; 
    }

    await box.put(habitId, {
      'streak': newStreak,
      'lastCompletedDate': newLastDate,
    });
  }
}
