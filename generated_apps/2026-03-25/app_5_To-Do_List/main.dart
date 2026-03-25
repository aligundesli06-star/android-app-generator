import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final List<String> _tasks = [];
  final List<bool> _taskStatus = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              tasks: _tasks,
              taskStatus: _taskStatus,
              onAddTask: _addTask,
            ),
            ProgressScreen(
              tasks: _tasks,
              taskStatus: _taskStatus,
            ),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onToggleDarkMode: _toggleDarkMode,
              onLanguageChange: _changeLanguage,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTask,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _addTask() {
    setState(() {
      _tasks.add('New Task ${_tasks.length + 1}');
      _taskStatus.add(false);
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() => _isDarkMode = value);
  }

  void _changeLanguage(String value) {
    setState(() => _language = value);
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> tasks;
  final List<bool> taskStatus;
  final VoidCallback onAddTask;

  const HomeScreen({
    super.key,
    required this.tasks,
    required this.taskStatus,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Checkbox(
                    value: taskStatus[index],
                    onChanged: (value) => taskStatus[index] = value!,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    tasks[index],
                    style: Theme.of(context).textTheme.titleLarge,
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
  final List<String> tasks;
  final List<bool> taskStatus;

  const ProgressScreen({
    super.key,
    required this.tasks,
    required this.taskStatus,
  });

  @override
  Widget build(BuildContext context) {
    int completedTasks = 0;
    for (var status in taskStatus) {
      if (status) {
        completedTasks++;
      }
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$completedTasks/${tasks.length} tasks completed',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: (completedTasks / tasks.length) * 100,
                height: 16,
              ),
              const SizedBox(width: 16),
              Text(
                '${(completedTasks / tasks.length * 100).round()}%',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final void Function(bool) onToggleDarkMode;
  final void Function(String) onLanguageChange;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.language,
    required this.onToggleDarkMode,
    required this.onLanguageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Dark Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: onToggleDarkMode,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                onChanged: onLanguageChange,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}