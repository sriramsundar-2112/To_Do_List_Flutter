import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  late Box<Task> _taskBox;

  List<Task> _tasks = [];

  String _searchQuery = '';
  int _filterIndex = 0;

  TaskProvider() {
    _init();
  }

  Future<void> _init() async {
    _taskBox = Hive.box<Task>('tasks');
    _tasks = _taskBox.values.toList();
    notifyListeners();
  }

  List<Task> get tasks {
    List<Task> filtered = _tasks;
    if (_filterIndex == 1) {
      filtered = filtered.where((t) => t.isCompleted).toList();
    } else if (_filterIndex == 2) {
      filtered = filtered.where((t) => !t.isCompleted).toList();
    }
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((t) => t.title.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return filtered;
  }

  void setFilter(int index) {
    _filterIndex = index;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    _tasks.insert(0, task);
    await _taskBox.put(task.id, task);
    notifyListeners();
  }

  Future<void> updateTask(Task updatedTask) async {
    final idx = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (idx != -1) {
      _tasks[idx] = updatedTask;
      await _taskBox.put(updatedTask.id, updatedTask);
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((t) => t.id == id);
    await _taskBox.delete(id);
    notifyListeners();
  }

  Task? getTaskById(String id) {
    try {
      return _tasks.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> toggleTaskStatus(String id) async {
    final idx = _tasks.indexWhere((t) => t.id == id);
    if (idx != -1) {
      _tasks[idx].isCompleted = !_tasks[idx].isCompleted;
      await _taskBox.put(_tasks[idx].id, _tasks[idx]);
      notifyListeners();
    }
  }

  Future<void> refreshTasks() async {
    _tasks = _taskBox.values.toList();
    notifyListeners();
  }
}
