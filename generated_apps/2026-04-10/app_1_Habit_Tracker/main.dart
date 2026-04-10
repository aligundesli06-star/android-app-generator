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

  final List<Habit> _habits = [];
  final Timer? _timer;

  void _addHabit() {
    setState(() {
      _habits.add(Habit(title: 'New Habit', completed: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: _isDarkMode
          ? ThemeData(
              brightness: Brightness.dark,
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
              habits: _habits,
              onAddHabit: _addHabit,
            ),
            ProgressScreen(
              habits: _habits,
            ),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onLanguageChanged: (language) {
                setState(() {
                  _language = language;
                });
              },
              onDarkModeChanged: (isDarkMode) {
                setState(() {
                  _isDarkMode = isDarkMode;
                });
              },
            ),
          ],
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
        floatingActionButton: FloatingActionButton(
          onPressed: _addHabit,
          tooltip: 'Add Habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final String title;
  bool completed;

  Habit({required this.title, this.completed = false});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final VoidCallback onAddHabit;

  const HomeScreen({Key? key, required this.habits, required this.onAddHabit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: habits
            .map(
              (habit) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      habit.completed
                          ? const Icon(Icons.check_box, color: Colors.green)
                          : const Icon(Icons.check_box_outline_blank, color: Colors.grey),
                      const SizedBox(width: 16),
                      Text(habit.title, style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Habit> habits;

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: habits
            .map(
              (habit) => Row(
                children: [
                  Text(
                    habit.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  habit.completed
                      ? const Icon(Icons.check_box, color: Colors.green)
                      : const Icon(Icons.check_box_outline_blank, color: Colors.grey),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final VoidCallback onLanguageChanged;
  final VoidCallback onDarkModeChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onLanguageChanged,
    required this.onDarkModeChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _language = 'English';
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _language = widget.language;
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode'),
              const Spacer(),
              Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  widget.onDarkModeChanged();
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('Language'),
              const Spacer(),
              DropdownButton(
                value: _language,
                items: const [
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 'English',
                  ),
                  DropdownMenuItem(
                    child: Text('Türkçe'),
                    value: 'Turkish',
                  ),
                  DropdownMenuItem(
                    child: Text('Español'),
                    value: 'Spanish',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _language = value as String;
                  });
                  widget.onLanguageChanged();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onLanguageChanged(String language) {
    setState(() {
      _language = language;
    });
    widget.onLanguageChanged();
  }
}