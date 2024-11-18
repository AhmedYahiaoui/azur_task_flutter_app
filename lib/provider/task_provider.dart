import 'package:azur_tech_task_app/controllers/services/notification_service.dart';
import 'package:azur_tech_task_app/controllers/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService;
  final NotificationService _notificationService = NotificationService();

  final List<Task> _tasks = [];
  DateTime _selectedDate = DateTime.now();

  TaskProvider(this._taskService);

  List<Task> get tasks => _tasks;
  TaskService get service => _taskService;
  DateTime get selectedDate => _selectedDate;

  // Method to add new task (into the Provider)
  void addTask(Task task) async {
    _tasks.add(task);
    notifyListeners();

    // Schedule a notification for the task
    if (task.isNotify && task.startTime.isAfter(DateTime.now())) {
      await _notificationService.scheduleNotification(
        scheduledTime: task.startTime,
        id: task.hash ?? 100,
        title: task.title,
        body: task.description,
      );
    }
  }

// Method to delete task (from the Provider)
  void removeTask(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      // Cancel the notification associated with this task
      await _notificationService.cancelNotification(tasks[index].hash ?? 100);

      _tasks.removeWhere((task) => task.id == id);
      notifyListeners();
    }
  }

// Method to update a task (into the Provider)
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

// Method to update notification for task (into the Provider)
  void updateNotificationTask(
      {required String id, required bool isNotify}) async {
    final index = _tasks.indexWhere((task) => task.id == id);

    if (index != -1) {
      Task _task = _tasks[index]; // temp

      // Cancel the old notification
      await _notificationService.cancelNotification(_task.hash ?? 100);

      // Schedule a new notification if needed
      if (isNotify && _task.startTime.isAfter(DateTime.now())) {
        await _notificationService.scheduleNotification(
          scheduledTime: _task.startTime,
          id: _task.hash ?? 1000,
          title: _task.title,
          body: _task.description,
        );
      }

      final task = Task(
        id: _task.id,
        userId: _task.userId,
        title: _task.title,
        description: _task.description,
        startTime: _task.startTime,
        endTime: _task.endTime,
        createdDate: _task.createdDate,
        isNotify: isNotify,
        isFavorit: _task.isFavorit,
      );
      _tasks[index] = task;
      notifyListeners();
    }
  }

// Method to update favorit for task (into the Provider) updateFavoritTask
  void updateFavoritTask({required String id, required bool isFavorit}) {
    final index = _tasks.indexWhere((task) => task.id == id);

    if (index != -1) {
      final task = Task(
        id: _tasks[index].id,
        userId: _tasks[index].userId,
        title: _tasks[index].title,
        description: _tasks[index].description,
        startTime: _tasks[index].startTime,
        endTime: _tasks[index].endTime,
        createdDate: _tasks[index].createdDate,
        isNotify: _tasks[index].isNotify,
        isFavorit: isFavorit,
      );
      _tasks[index] = task;
      notifyListeners();
    }
  }

// Method to get tasks by given date (From the Provider)
  List<Task> getTasksByDate(DateTime date) {
    List<Task> tasks =
        _tasks.where((task) => isSameDay(task.createdDate, date)).toList();
    tasks.sort(
        (a, b) => a.startTime.toString().compareTo(b.startTime.toString()));

    return tasks;
  }

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
