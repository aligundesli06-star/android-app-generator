```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const TaskTwinApp());
}

class TaskTwinApp extends StatelessWidget {
  const TaskTwinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskTwin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskTwinHomePage(),
    );
  }
}

class TaskTwinHomePage extends StatefulWidget {
  const TaskTwinHomePage({Key? key}) : super(key: key);

  @override
  State<TaskTwinHomePage> createState() => _TaskTwinHomePageState();
}

class _TaskTwinHomePageState extends State<TaskTwinHomePage> {
  final List<Task> _tasks = [];
  final _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: _taskController.text, isCompleted: false));
        _taskController.clear();
      });
    }
  }

  void _toggleComplete(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskTwin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: 'New Task',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add Task'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) => _toggleComplete(task),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteTask(task),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  final String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}
```