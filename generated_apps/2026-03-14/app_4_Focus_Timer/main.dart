import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';
  int _workTime = 25;
  int _breakTime = 5;
  List<String> _tasks = [];
  Timer? _timer;
  int _seconds = 0;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _addTask() {
    setState(() {
      _tasks.add('New task ${_tasks.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            HomeScreen(
              workTime: _workTime,
              breakTime: _breakTime,
              seconds: _seconds,
              startTimer: _startTimer,
              addTask: _addTask,
              tasks: _tasks,
            ),
            ProgressScreen(
              tasks: _tasks,
            ),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              toggleDarkMode: _toggleDarkMode,
              selectLanguage: _selectLanguage,
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTask,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final int workTime;
  final int breakTime;
  final int seconds;
  final VoidCallback startTimer;
  final VoidCallback addTask;
  final List<String> tasks;

  const HomeScreen({
    Key? key,
    required this.workTime,
    required this.breakTime,
    required this.seconds,
    required this.startTimer,
    required this.addTask,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Work Time',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '$workTime min',
                    style: const TextStyle(fontSize: 48),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Break Time',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '$breakTime min',
                    style: const TextStyle(fontSize: 48),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Timer',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    '$seconds s',
                    style: const TextStyle(fontSize: 48),
                  ),
                  ElevatedButton(
                    onPressed: startTimer,
                    child: const Text('Start'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(tasks[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<String> tasks;

  const ProgressScreen({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Text('Completed: '),
              Text(
                '0',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          Row(
            children: const [
              Text('Total: '),
              Text(
                '0',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(tasks[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final String language;
  final VoidCallback toggleDarkMode;
  final VoidCallback Function(String) selectLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.toggleDarkMode,
    required this.selectLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  toggleDarkMode();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: language,
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
                onChanged: (value) {
                  selectLanguage(value as String);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}