import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'package:intl/intl.dart';

class AddEditTaskScreen extends StatefulWidget {
  static const routeName = '/add_edit_task';
  const AddEditTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _id;
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();
  TaskPriority _priority = TaskPriority.medium;
  bool _isCompleted = false;
  bool _isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is String) {
      final task = Provider.of<TaskProvider>(context, listen: false).getTaskById(args);
      if (task != null) {
        _isEdit = true;
        _id = task.id;
        _title = task.title;
        _description = task.description;
        _dueDate = task.dueDate;
        _priority = task.priority;
        _isCompleted = task.isCompleted;
      }
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final provider = Provider.of<TaskProvider>(context, listen: false);

      final task = Task(
        id: _id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _title,
        description: _description,
        dueDate: _dueDate,
        priority: _priority,
        isCompleted: _isCompleted,
      );

      if (_isEdit) {
        provider.updateTask(task);
      } else {
        provider.addTask(task);
      }

      Navigator.pop(context);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Task' : 'Add Task'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _title,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) => val == null || val.isEmpty ? 'Enter a title' : null,
                    onSaved: (val) => _title = val ?? '',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    onSaved: (val) => _description = val ?? '',
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Due Date'),
                    subtitle: Text(DateFormat.yMMMd().format(_dueDate)),
                    trailing: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _pickDate,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<TaskPriority>(
                    value: _priority,
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: TaskPriority.values.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text(
                          p.name[0].toUpperCase() + p.name.substring(1),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _priority = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    value: _isCompleted,
                    onChanged: (val) => setState(() => _isCompleted = val),
                    title: const Text('Mark as Completed'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    icon: Icon(_isEdit ? Icons.save : Icons.add),
                    onPressed: _submit,
                    label: Text(_isEdit ? 'Save Changes' : 'Add Task'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
