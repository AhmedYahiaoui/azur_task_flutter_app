import 'package:azur_tech_task_app/controllers/services/task_service.dart';
import 'package:azur_tech_task_app/provider/task_provider.dart';
import '../models/task.dart';

class TaskController {
  final TaskService _taskService;
  final TaskProvider _taskProvider;

  TaskController(this._taskService, this._taskProvider);

  void addTask(Task task) {
    _taskProvider.addTask(task);
  }

  void removeTask(String id) {
    _taskProvider.removeTask(id);
  }

  void updateTask(Task task) {
    _taskProvider.updateTask(task);
  }

  List<Task> getTasksByDate(DateTime date) {
    return _taskProvider.getTasksByDate(date);
  }

  Future<bool> syncTasksWithServer() async {
    final success = await _taskService.sendTasksToServer(_taskProvider.tasks);
    return success;
  }

  Future<void> fetchTasksFromServer() async {
    final tasks = await _taskService.fetchTasksFromServer();
    for (var task in tasks) {
      _taskProvider.addTask(task);
    }
  }
}
