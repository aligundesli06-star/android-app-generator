import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FocusFlow',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';

  final _tasks = [
    {'title': 'Task 1', 'description': 'Description 1'},
    {'title': 'Task 2', 'description': 'Description 2'},
    {'title': 'Task 3', 'description': 'Description 3'},
  ];

  void _addTask() {
    setState(() {
      _tasks.add({
        'title': 'New Task',
        'description': 'New Description',
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(
          tasks: _tasks,
          isDarkMode: _isDarkMode,
        ),
        ProgressScreen(
          isDarkMode: _isDarkMode,
        ),
        SettingsScreen(
          isDarkMode: _isDarkMode,
          language: _language,
          onChanged: (value) {
            setState(() {
              _isDarkMode = value;
            });
          },
          onLanguageChange: (language) {
            setState(() {
              _language = language;
            });
          },
        ),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List _tasks;
  final bool _isDarkMode;

  const HomeScreen({Key? key, required this.tasks, required this.isDarkMode}) : _tasks = tasks, _isDarkMode = isDarkMode, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.list),
                    SizedBox(width: 16),
                    Text('Task List', style: TextStyle(fontSize: 20)),
                  ],
                ),
                const SizedBox(height: 16),
                ..._tasks.map((task) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(task['title'], style: const TextStyle(fontSize: 18)),
                          const SizedBox(height: 8),
                          Text(task['description'], style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final bool _isDarkMode;

  const ProgressScreen({Key? key, required this.isDarkMode}) : _isDarkMode = isDarkMode, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.grey[700] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('Completed Tasks: 0', style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.grey[700] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('Total Tasks: 0', style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool _isDarkMode;
  final String _language;
  final Function _onChanged;
  final Function _onLanguageChange;

  const SettingsScreen({Key? key, required this.isDarkMode, required this.language, required this.onChanged, required this.onLanguageChange}) : _isDarkMode = isDarkMode, _language = language, _onChanged = onChanged, _onLanguageChange = onLanguageChange, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  _onChanged(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language,
                onChanged: (value) {
                  _onLanguageChange(value);
                },
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