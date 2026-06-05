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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        if (_workTime > 0) {
          _workTime--;
        } else if (_breakTime > 0) {
          _breakTime--;
        } else {
          _workTime = 25;
          _breakTime = 5;
        }
      });
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
              startTimer: _startTimer,
              tasks: _tasks,
              addTask: (task) {
                setState(() {
                  _tasks.add(task);
                });
              },
            ),
            ProgressScreen(
              workTime: _workTime,
              breakTime: _breakTime,
              tasks: _tasks,
            ),
            SettingsScreen(
              language: _language,
              isDarkMode: _isDarkMode,
              onChangeLanguage: (language) {
                setState(() {
                  _language = language;
                });
              },
              onChangeTheme: (isDarkMode) {
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final _controller = TextEditingController();
                return AlertDialog(
                  content: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _tasks.add(_controller.text);
                        setState(() {});
                      },
                      child: const Text('Add'),
                    ),
                  ],
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
  final int workTime;
  final int breakTime;
  final VoidCallback startTimer;
  final List<String> tasks;
  final VoidCallback addTask;

  const HomeScreen({
    Key? key,
    required this.workTime,
    required this.breakTime,
    required this.startTimer,
    required this.tasks,
    required this.addTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.timer,
                    size: 48,
                  ),
                  Text(
                    'Work Time: $workTime minutes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Break Time: $breakTime minutes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  ElevatedButton(
                    onPressed: startTimer,
                    child: const Text('Start Timer'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      tasks[index],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
  final int workTime;
  final int breakTime;
  final List<String> tasks;

  const ProgressScreen({
    Key? key,
    required this.workTime,
    required this.breakTime,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.timer,
                    size: 48,
                  ),
                  Text(
                    'Work Time: $workTime minutes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.timer_off,
                    size: 48,
                  ),
                  Text(
                    'Break Time: $breakTime minutes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Tasks: ${tasks.length}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final String language;
  final bool isDarkMode;
  final VoidCallback onChangeLanguage;
  final VoidCallback onChangeTheme;

  const SettingsScreen({
    Key? key,
    required this.language,
    required this.isDarkMode,
    required this.onChangeLanguage,
    required this.onChangeTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: language,
                items: [
                  const DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  const DropdownMenuItem(
                    child: Text('Turkish'),
                    value: 'Turkish',
                  ),
                  const DropdownMenuItem(
                    child: Text('Spanish'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  onChangeLanguage();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Theme:'),
              const SizedBox(width: 16),
              Switch(
                value: isDarkMode,
                onChanged: (value) {
                  onChangeTheme();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}