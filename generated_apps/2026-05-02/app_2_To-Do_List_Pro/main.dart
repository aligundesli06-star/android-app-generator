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
  Locale? _locale;
  bool _isDarkMode = false;
  List<String> _tasks = [];
  List<String> _progress = [];

  void _addTask() {
    setState(() {
      _tasks.add('New Task');
    });
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _changeTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      theme: _isDarkMode ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo) : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List Pro'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
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
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(tasks: _tasks, addTask: _addTask),
            ProgressScreen(progress: _progress),
            SettingsScreen(changeLanguage: _changeLanguage, changeTheme: _changeTheme),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTask,
          tooltip: 'Add Task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> tasks;
  final VoidCallback addTask;

  const HomeScreen({Key? key, required this.tasks, required this.addTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
              child: Row(
                children: [
                  const Icon(Icons.task),
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
  final List<String> progress;

  const ProgressScreen({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.bar_chart),
              SizedBox(width: 16),
              Text('Progress'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text('50%')),
              ),
              const SizedBox(width: 16),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text('75%')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final VoidCallback changeLanguage;
  final VoidCallback changeTheme;

  const SettingsScreen({Key? key, required this.changeLanguage, required this.changeTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16),
              DropdownButton(
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: Locale('en', 'US'),
                  ),
                  DropdownMenuItem(
                    child: Text('Turkish'),
                    value: Locale('tr', 'TR'),
                  ),
                  DropdownMenuItem(
                    child: Text('Spanish'),
                    value: Locale('es', 'ES'),
                  ),
                ],
                onChanged: (value) {
                  changeLanguage();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.brightness_4),
              const SizedBox(width: 16),
              const Text('Dark Mode'),
              const SizedBox(width: 16),
              Switch(
                value: true,
                onChanged: (value) {
                  changeTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}