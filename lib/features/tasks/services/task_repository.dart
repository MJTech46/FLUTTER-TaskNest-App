import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/task.dart';

class TaskRepository {
  static const String _tasksKey = 'tasks';

  final SharedPreferencesAsync _preferences;

  TaskRepository({
    required this._preferences,
  });

  List<Task> _tasks = [];

  List<Task> getTasks() {
    return List.unmodifiable(_tasks);
  }

  Future<void> loadTasks() async {
    final storedTasks = await _preferences.getString(_tasksKey);

    if (storedTasks == null || storedTasks.isEmpty) {
      _tasks = [];
      return;
    }

    try {
      final List<dynamic> decoded = jsonDecode(storedTasks);

      _tasks = decoded
          .map(
            (task) => Task.fromJson(
              Map<String, dynamic>.from(task as Map),
            ),
          )
          .toList();
    } catch (_) {
      _tasks = [];
    }
  }

  Future<void> _saveTasks() async {
    final encodedTasks = jsonEncode(
      _tasks.map((task) => task.toJson()).toList(),
    );

    await _preferences.setString(
      _tasksKey,
      encodedTasks,
    );
  }

  Future<void> addTask(Task task) async {
    _tasks.add(task);
    await _saveTasks();
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere(
      (task) => task.id == id,
    );

    await _saveTasks();
  }

  Future<void> updateTask(Task updatedTask) async {
    final index = _tasks.indexWhere(
      (task) => task.id == updatedTask.id,
    );

    if (index != -1) {
      _tasks[index] = updatedTask;
      await _saveTasks();
    }
  }
}