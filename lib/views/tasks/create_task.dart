import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ostad_flutter9_assignment4/services/task_service.dart';
import 'package:ostad_flutter9_assignment4/widgets/custom_textfield.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _status = 'New';
  bool _isLoading = false;

  Future<void> _createTask() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await Provider.of<TaskService>(context, listen: false).createTask(
        _titleController.text.trim(),
        _descriptionController.text.trim(),
        _status,
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create task: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create New Task')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                controller: _titleController,
                label: 'Title',
                validator: (value) => value!.isEmpty ? 'Please enter title' : null,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _descriptionController,
                label: 'Description',
                validator: (value) => value!.isEmpty ? 'Please enter description' : null,
                maxLines: 5,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _status,
                items: ['New', 'In Progress', 'Completed']
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _status = value!),
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _createTask,
                child: Text('Create Task'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}