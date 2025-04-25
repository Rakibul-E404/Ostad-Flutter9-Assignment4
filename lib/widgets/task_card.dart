import 'package:flutter/material.dart';
import 'package:ostad_flutter9_assignment4/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(String) onStatusChanged;
  final Function() onDelete;

  const TaskCard({
    required this.task,
    required this.onStatusChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      onDelete();
                    } else {
                      onStatusChanged(value);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'New',
                      child: Text('Mark as New'),
                    ),
                    PopupMenuItem(
                      value: 'In Progress',
                      child: Text('Mark as In Progress'),
                    ),
                    PopupMenuItem(
                      value: 'Completed',
                      child: Text('Mark as Completed'),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(task.description),
            SizedBox(height: 8),
            Chip(
              label: Text(task.status),
              backgroundColor: _getStatusColor(task.status),
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