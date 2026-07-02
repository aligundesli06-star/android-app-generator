import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const TodoTaskApp());

class TodoTaskApp extends StatefulWidget {
  const TodoTaskApp({super.key});

  @override
  State<TodoTaskApp> createState() => _TodoTaskAppState();
}

class _TodoTaskAppState extends State<TodoTaskApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<TodoTask> _tasks = [
    const TodoTask(title: 'Task 1', deadline: '2024-01-01', isCompleted: false),
    const TodoTask(title: 'Task 2', deadline: '2024-01-15', isCompleted: false),
    const TodoTask(title: 'Task 3', deadline: '2024-02-01', isCompleted: true),
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _addNewTask() {
    final newTask = TodoTask(title: 'New Task', deadline: '2024-01-01', isCompleted: false);
    setState(() {
      _tasks.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoTask',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              primarySwatch: Colors.indigo,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
            ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(tasks: _tasks, addNewTask: _addNewTask),
            ProgressScreen(tasks: _tasks),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              toggleDarkMode: _toggleDarkMode,
              changeLanguage: _changeLanguage,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewTask,
          tooltip: 'Add New Task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TodoTask {
  final String title;
  final String deadline;
  final bool isCompleted;

  const TodoTask({required this.title, required this.deadline, required this.isCompleted});
}

class HomeScreen extends StatelessWidget {
  final List<TodoTask> tasks;
  final void Function() addNewTask;

  const HomeScreen({super.key, required this.tasks, required this.addNewTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(task.isCompleted ? Icons.check_circle : Icons.circle),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title, style: Theme.of(context).textTheme.titleLarge),
                      Text(task.deadline),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<TodoTask> tasks;

  const ProgressScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final totalTasks = tasks.length;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Text('Completed: $completedTasks'),
              const SizedBox(width: 16),
              Text('Total: $totalTasks'),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: completedTasks / totalTasks,
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final void Function() toggleDarkMode;
  final void Function(String) changeLanguage;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.changeLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) => toggleDarkMode(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language'),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: const [
                  DropdownMenuItem(child: Text('English'), value: 'English'),
                  DropdownMenuItem(child: Text('Türkçe'), value: 'Turkish'),
                  DropdownMenuItem(child: Text('Español'), value: 'Spanish'),
                ],
                onChanged: (value) => changeLanguage(value!),
              ),
            ],
          ),
        ],
      ),
    );
  }
}