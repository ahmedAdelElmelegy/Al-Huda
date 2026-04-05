import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import '../model/ramadan_model.dart';

abstract class RamadanRepo {
  Future<RamadanData> getRamadanData();
  Future<void> toggleTask(int day, int taskId);
  bool isTaskCompleted(int day, int taskId);
  int getFastingDaysCount();
  Set<int> getCompletedTasksForDay(int day);
}

class RamadanRepoImpl implements RamadanRepo {
  final Box _ramadanBox = Hive.box('ramadan_box');

  @override
  Future<RamadanData> getRamadanData() async {
    final String response = await rootBundle.loadString(
      'assets/data/ramadan_data.json',
    );
    final data = await json.decode(response);
    return RamadanData.fromJson(data);
  }

  @override
  Future<void> toggleTask(int day, int taskId) async {
    final List<String> completed = _ramadanBox.get(
      'day_$day',
      defaultValue: <String>[],
    );
    if (completed.contains(taskId.toString())) {
      completed.remove(taskId.toString());
    } else {
      completed.add(taskId.toString());
    }
    await _ramadanBox.put('day_$day', completed);

    // Update total fasting days if taskId is 1 (Fasting task)
    if (taskId == 1) {
      int count = _ramadanBox.get('fasting_days', defaultValue: 0);
      if (completed.contains('1')) {
        count++;
      } else {
        if (count > 0) count--;
      }
      await _ramadanBox.put('fasting_days', count);
    }
  }

  @override
  bool isTaskCompleted(int day, int taskId) {
    final List<String> completed = _ramadanBox.get(
      'day_$day',
      defaultValue: <String>[],
    );
    return completed.contains(taskId.toString());
  }

  @override
  int getFastingDaysCount() {
    return _ramadanBox.get('fasting_days', defaultValue: 0);
  }

  @override
  Set<int> getCompletedTasksForDay(int day) {
    final List<String> completed = _ramadanBox.get(
      'day_$day',
      defaultValue: <String>[],
    );
    return completed.map((e) => int.parse(e)).toSet();
  }
}
