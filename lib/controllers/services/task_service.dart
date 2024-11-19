import 'dart:convert';
import 'package:azur_tech_task_app/models/task.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String baseUrl = "https://example.com/api/todo/";
  late http.Client client;

  TaskService({http.Client? httpClient}) {
    client = httpClient ?? http.Client();
  }

  Future<Task?> addTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: json.encode(task),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return task;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> sendTasksToServer(List<Task> tasks) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: json.encode(tasks.map((task) => task.toJson()).toList()),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<Task>> fetchTasksFromServer() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((task) => Task.fromJson(task)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
