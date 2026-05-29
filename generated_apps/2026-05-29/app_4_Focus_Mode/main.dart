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
      title: 'Focus Mode',
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

  final List<String> _languages = const ['English', 'Turkish', 'Spanish'];

  final List<Task> _tasks = [
    Task('Study', Icons.book, const Color(0xFF9C69E7)),
    Task('Work', Icons.work, const Color(0xFF34C759)),
    Task('Exercise', Icons.directions_run, const Color(0xFF34A85A)),
  ];

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _addTask() {
    setState(() {
      _tasks.add(Task('New Task', Icons.add, const Color(0xFF808080)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Mode'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleDarkMode,
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(tasks: _tasks),
          ProgressScreen(),
          SettingsScreen(
            isDarkMode: _isDarkMode,
            language: _language,
            languages: _languages,
            toggleDarkMode: _toggleDarkMode,
            changeLanguage: (language) {
              setState(() {
                _language = language;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Task {
  final String title;
  final IconData icon;
  final Color color;

  Task(this.title, this.icon, this.color);
}

class HomeScreen extends StatelessWidget {
  final List<Task> tasks;

  const HomeScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: tasks
            .map((task) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(task.icon, color: task.color),
                        const SizedBox(width: 16),
                        Text(
                          task.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              Text(
                'Progress',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '25%',
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
  final List<String> languages;
  final VoidCallback toggleDarkMode;
  final ValueChanged<String> changeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.languages,
    required this.toggleDarkMode,
    required this.changeLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.dark_mode),
              const SizedBox(width: 16),
              Text(
                isDarkMode ? 'Dark Mode' : 'Light Mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: languages
                    .map((language) => DropdownMenuItem(
                          value: language,
                          child: Text(language),
                        ))
                    .toList(),
                onChanged: (value) {
                  changeLanguage(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}