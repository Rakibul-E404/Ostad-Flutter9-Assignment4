import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../services/task_service.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);
    final dateFormat = DateFormat('MMM dd, yyyy hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              taskService.deleteTask(task.id);
              taskService.fetchTaskStatusCount();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Chip(
              label: Text(task.status),
              backgroundColor: _getStatusColor(task.status),
            ),
            SizedBox(height: 20),
            Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(task.description),
            SizedBox(height: 20),
            Text(
              'Created At',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(dateFormat.format(task.createdAt)),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              value: task.status,
              items: ['New', 'In Progress', 'Completed']
                  .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status),
              ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  taskService.updateTaskStatus(task.id, value);
                  Navigator.pop(context);
                }
              },
              decoration: InputDecoration(
                labelText: 'Update Status',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.blue[100]!;
      case 'In Progress':
        return Colors.orange[100]!;
      case 'Completed':
        return Colors.green[100]!;
      default:
        return Colors.grey[100]!;
    }
  }
}