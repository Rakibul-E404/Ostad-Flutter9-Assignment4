import 'package:flutter/material.dart';
import 'package:ostad_flutter9_assignment4/views/profile/profile_view.dart';
import 'package:ostad_flutter9_assignment4/views/tasks/create_task.dart';
import 'package:ostad_flutter9_assignment4/views/tasks/task_list.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/task_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    TaskListScreen(),
    ProfileView(),
  ];

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Provider.of<AuthService>(context, listen: false).logout(),
          ),
        ],
      ),
      body: _children[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateTaskScreen()),
          ).then((_) => taskService.fetchTaskStatusCount());
        },
        child: Icon(Icons.add),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}