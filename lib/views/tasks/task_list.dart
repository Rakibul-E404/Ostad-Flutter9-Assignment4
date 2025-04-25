import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ostad_flutter9_assignment4/models/task_model.dart';
import 'package:ostad_flutter9_assignment4/services/task_service.dart';
import 'package:ostad_flutter9_assignment4/widgets/task_card.dart';
import 'package:ostad_flutter9_assignment4/widgets/stat_card.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskService>(context, listen: false).fetchTaskStatusCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 8,
            children: [
              StatCard(
                count: taskService.statusCount.values.fold(0, (a, b) => a + b),
                label: 'All',
                isSelected: _selectedStatus == 'All',
                onTap: () {
                  setState(() => _selectedStatus = 'All');
                  taskService.fetchTasksByStatus('All');
                },
              ),
              ...taskService.statusCount.entries.map((entry) => StatCard(
                count: entry.value,
                label: entry.key,
                isSelected: _selectedStatus == entry.key,
                onTap: () {
                  setState(() => _selectedStatus = entry.key);
                  taskService.fetchTasksByStatus(entry.key);
                },
              )).toList(),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: taskService.tasks.length,
            itemBuilder: (context, index) {
              final task = taskService.tasks[index];
              return TaskCard(
                task: task,
                onStatusChanged: (newStatus) {
                  taskService.updateTaskStatus(task.id, newStatus);
                },
                onDelete: () {
                  taskService.deleteTask(task.id);
                  taskService.fetchTaskStatusCount();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}