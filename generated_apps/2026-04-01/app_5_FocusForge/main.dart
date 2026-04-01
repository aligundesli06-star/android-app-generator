import 'package:flutter/material.dart';
import 'dart:async';

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
  ThemeMode _themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  final _taskList = <String>[];
  final _pomodoroTimer = TimerController();

  void _addTask() {
    setState(() {
      _taskList.add('New Task ${_taskList.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      title: 'FocusForge',
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              taskList: _taskList,
              pomodoroTimer: _pomodoroTimer,
            ),
            ProgressScreen(
              taskList: _taskList,
            ),
            SettingsScreen(
              onThemeModeChanged: (themeMode) {
                setState(() {
                  _themeMode = themeMode;
                });
              },
              onLocaleChanged: (locale) {
                setState(() {
                  _locale = locale;
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
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: 'Settings',
            ),
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

class TimerController {
  Timer? _timer;
  int _seconds = 25 * 60;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  int get seconds => _seconds;
}

class HomeScreen extends StatefulWidget {
  final List<String> taskList;
  final TimerController pomodoroTimer;

  const HomeScreen({
    Key? key,
    required this.taskList,
    required this.pomodoroTimer,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: Row(
                children: [
                  const Icon(Icons.timer),
                  const SizedBox(width: 16),
                  Text(
                    '${widget.pomodoroTimer.seconds ~/ 60}:${widget.pomodoroTimer.seconds % 60}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.taskList.length,
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
                        Text(widget.taskList[index]),
                      ],
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
  final List<String> taskList;

  const ProgressScreen({
    Key? key,
    required this.taskList,
  }) : super(key: key);

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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.indigo[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text('50%'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final void Function(ThemeMode) onThemeModeChanged;
  final void Function(Locale) onLocaleChanged;

  const SettingsScreen({
    Key? key,
    required this.onThemeModeChanged,
    required this.onLocaleChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _locale = 'en';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.toggle_on),
              const SizedBox(width: 16),
              Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    widget.onThemeModeChanged(value ? ThemeMode.dark : ThemeMode.light);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 16),
              Text('Language'),
              const Spacer(),
              DropdownButton(
                value: _locale,
                onChanged: (value) {
                  setState(() {
                    _locale = value as String;
                    widget.onLocaleChanged(Locale(value));
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'tr',
                    child: Text('Turkish'),
                  ),
                  DropdownMenuItem(
                    value: 'es',
                    child: Text('Spanish'),
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