// import 'package:flutter/material.dart';
// import 'package:ostad_flutter9_assignment4/models/task_model.dart';
// import 'package:ostad_flutter9_assignment4/services/api_service.dart';
//
// class TaskService with ChangeNotifier {
//   final ApiService _apiService = ApiService();
//   List<Task> _tasks = [];
//   Map<String, int> _statusCount = {};
//
//   List<Task> get tasks => _tasks;
//   Map<String, int> get statusCount => _statusCount;
//
//   Future<void> createTask(String title, String description, String status) async {
//     final response = await _apiService.post('createTask', {
//       'title': title,
//       'description': description,
//       'status': status,
//     }, token: _apiService.token);
//
//     _tasks.add(Task.fromJson(response['data']));
//     notifyListeners();
//   }
//
//   Future<void> deleteTask(String taskId) async {
//     await _apiService.delete('deleteTask/$taskId', token: _apiService.token);
//     _tasks.removeWhere((task) => task.id == taskId);
//     notifyListeners();
//   }
//
//   Future<void> updateTaskStatus(String taskId, String status) async {
//     await _apiService.put('updateTaskStatus/$taskId/$status', {}, token: _apiService.token);
//     final index = _tasks.indexWhere((task) => task.id == taskId);
//     if (index != -1) {
//       _tasks[index] = _tasks[index].copyWith(status: status);
//     }
//     notifyListeners();
//   }
//
//   Future<void> fetchTasksByStatus(String status) async {
//     final response = await _apiService.get('listTaskByStatus/$status', token: _apiService.token);
//     _tasks = (response['data'] as List).map((e) => Task.fromJson(e)).toList();
//     notifyListeners();
//   }
//
//   Future<void> fetchTaskStatusCount() async {
//     final response = await _apiService.get('taskStatusCount', token: _apiService.token);
//     _statusCount = Map<String, int>.from(response['data']);
//     notifyListeners();
//   }
// }



import 'package:flutter/material.dart';
import '../models/task_model.dart';
import 'api_service.dart';
import 'auth_service.dart';

class TaskService with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AuthService _authService;
  List<Task> _tasks = [];
  Map<String, int> _statusCount = {};

  TaskService(this._authService);

  List<Task> get tasks => _tasks;
  Map<String, int> get statusCount => _statusCount;

  Future<void> createTask(String title, String description, String status) async {
    final token = _authService.token;
    if (token == null) throw Exception('Not authenticated');

    final response = await _apiService.post('createTask', {
      'title': title,
      'description': description,
      'status': status,
    }, token: token);

    _tasks.add(Task.fromJson(response['data']));
    notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    final token = _authService.token;
    if (token == null) throw Exception('Not authenticated');

    await _apiService.delete('deleteTask/$taskId', token: token);
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  Future<void> updateTaskStatus(String taskId, String status) async {
    final token = _authService.token;
    if (token == null) throw Exception('Not authenticated');

    await _apiService.put('updateTaskStatus/$taskId/$status', {}, token: token);
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(status: status);
    }
    notifyListeners();
  }

  Future<void> fetchTasksByStatus(String status) async {
    final token = _authService.token;
    if (token == null) throw Exception('Not authenticated');

    final response = await _apiService.get('listTaskByStatus/$status', token: token);
    _tasks = (response['data'] as List).map((e) => Task.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> fetchTaskStatusCount() async {
    final token = _authService.token;
    if (token == null) throw Exception('Not authenticated');

    final response = await _apiService.get('taskStatusCount', token: token);
    _statusCount = Map<String, int>.from(response['data']);
    notifyListeners();
  }
}