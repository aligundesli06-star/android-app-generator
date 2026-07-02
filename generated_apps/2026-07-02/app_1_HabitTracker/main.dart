import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';

void main() {
  runApp(const HabitTracker());
}

class HabitTracker extends StatefulWidget {
  const HabitTracker({Key? key}) : super(key: key);

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  int _currentIndex = 0;
  bool _isDarkMode = false;
  String _language = 'English';
  List<Habit> _habits = [
    Habit(id: 1, title: 'Wake Up Early', done: false),
    Habit(id: 2, title: 'Exercise', done: true),
    Habit(id: 3, title: 'Meditate', done: false),
  ];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _addHabit() {
    setState(() {
      _habits.add(Habit(id: _habits.length + 1, title: 'New Habit', done: false));
    });
  }

  void _toggleHabit(Habit habit) {
    setState(() {
      habit.done = !habit.done;
    });
  }

  void _changeTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('HabitTracker'),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              habits: _habits,
              onToggleHabit: _toggleHabit,
              language: _language,
            ),
            ProgressScreen(habits: _habits),
            SettingsScreen(
              isDarkMode: _isDarkMode,
              language: _language,
              onChangeTheme: _changeTheme,
              onChangeLanguage: _changeLanguage,
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
          onPressed: _addHabit,
          tooltip: 'Add Habit',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Habit {
  final int id;
  String title;
  bool done;

  Habit({required this.id, required this.title, required this.done});
}

class HomeScreen extends StatelessWidget {
  final List<Habit> habits;
  final Function(Habit) onToggleHabit;
  final String language;

  const HomeScreen({
    Key? key,
    required this.habits,
    required this.onToggleHabit,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Checkbox(
                    value: habits[index].done,
                    onChanged: (value) => onToggleHabit(habits[index]),
                  ),
                  const SizedBox(width: 16),
                  Text(habits[index].title),
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
  final List<Habit> habits;

  const ProgressScreen({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int doneCount = habits.where((habit) => habit.done).length;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.bar_chart),
              const SizedBox(width: 16),
              Text('Progress: $doneCount/${habits.length}'),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: habits.isEmpty ? 0 : doneCount / habits.length,
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final String language;
  final Function onChangeTheme;
  final Function(String) onChangeLanguage;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.language,
    required this.onChangeTheme,
    required this.onChangeLanguage,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Dark Mode:'),
              const SizedBox(width: 16),
              Switch(
                value: widget.isDarkMode,
                onChanged: (value) => widget.onChangeTheme(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Language:'),
              const SizedBox(width: 16),
              DropdownButton(
                value: widget.language,
                onChanged: (String? value) => widget.onChangeLanguage(value!),
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