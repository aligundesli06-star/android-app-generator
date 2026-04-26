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
  String _language = 'English';
  bool _isDarkMode = false;
  int _currentIndex = 0;
  List<String> _tasks = [];
  List<bool> _isCompleted = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Pro',
      theme: _isDarkMode
          ? ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.light,
            ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List Pro'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              tasks: _tasks,
              isCompleted: _isCompleted,
              addTask: (task) {
                setState(() {
                  _tasks.add(task);
                  _isCompleted.add(false);
                });
              },
              onComplete: (index) {
                setState(() {
                  _isCompleted[index] = !_isCompleted[index];
                });
              },
            ),
            ProgressScreen(
              tasks: _tasks,
              isCompleted: _isCompleted,
            ),
            SettingsScreen(
              language: _language,
              isDarkMode: _isDarkMode,
              onLanguageChange: (language) {
                setState(() {
                  _language = language;
                });
              },
              onDarkModeChange: (isDarkMode) {
                setState(() {
                  _isDarkMode = isDarkMode;
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final _controller = TextEditingController();
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'New Task',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _tasks.add(_controller.text);
                            _isCompleted.add(false);
                            setState(() {});
                          },
                          child: const Text('Add Task'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> tasks;
  final List<bool> isCompleted;
  final Function addTask;
  final Function onComplete;

  const HomeScreen({
    Key? key,
    required this.tasks,
    required this.isCompleted,
    required this.addTask,
    required this.onComplete,
  }) : super(key: key);

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
                  Expanded(
                    child: Text(
                      tasks[index],
                      style: TextStyle(
                        decoration: isCompleted[index]
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  Checkbox(
                    value: isCompleted[index],
                    onChanged: (value) {
                      onComplete(index);
                    },
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
  final List<bool> isCompleted;

  const ProgressScreen({
    Key? key,
    required this.tasks,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((task) => isCompleted[tasks.indexOf(task)]).length;
    final tasksCount = tasks.length;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Total Tasks: '),
              Text(tasksCount.toString()),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Completed Tasks: '),
              Text(completedTasks.toString()),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Progress: '),
              Text(((completedTasks / tasksCount) * 100).toStringAsFixed(2) + '%'),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final String language;
  final bool isDarkMode;
  final Function onLanguageChange;
  final Function onDarkModeChange;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.isDarkMode,
    required this.onLanguageChange,
    required this.onDarkModeChange,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _language;
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _language = widget.language;
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Language: '),
              DropdownButton(
                value: _language,
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
                  setState(() {
                    _language = value as String;
                  });
                  widget.onLanguageChange(_language);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Dark Mode: '),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  widget.onDarkModeChange(_isDarkMode);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}