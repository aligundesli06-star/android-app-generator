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
  List<Habit> habits = [
    Habit('Wake up at 6:00 AM', Icons.wb_sunny, true),
    Habit('Exercise for 30 minutes', Icons.directions_run, false),
    Habit('Meditate for 10 minutes', Icons.self_improvement, true),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(primarySwatch: Colors.indigo)
          : ThemeData.light().copyWith(primarySwatch: Colors.indigo),
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(habits, _addHabit),
            ProgressScreen(habits),
            SettingsScreen(_toggleDarkMode, _changeLanguage),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _addHabit() {
    setState(() {
      habits.add(Habit('New Habit', Icons.directions_run, false));
    });
  }
}

class Habit {
  String name;
  IconData icon;
  bool isCompleted;

  Habit(this.name, this.icon, this.isCompleted);
}

class HomeScreen extends StatefulWidget {
  final List<Habit> habits;
  final Function addHabit;

  const HomeScreen(this.habits, this.addHabit, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.habits.length,
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
                    Icon(
                      widget.habits[index].icon,
                      size: 30,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      widget.habits[index].name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    Checkbox(
                      value: widget.habits[index].isCompleted,
                      onChanged: (value) {
                        setState(() {
                          widget.habits[index].isCompleted = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final List<Habit> habits;

  const ProgressScreen(this.habits, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Total Habits: ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                habits.length.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Completed Habits: ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                habits.where((habit) => habit.isCompleted).length.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Uncompleted Habits: ',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                habits.where((habit) => !habit.isCompleted).length.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  final Function toggleDarkMode;
  final Function changeLanguage;

  const SettingsScreen(this.toggleDarkMode, this.changeLanguage, {Key? key})
      : super(key: key);

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
              const Text(
                'Dark Mode: ',
                style: TextStyle(fontSize: 18),
              ),
              Switch(
                value: _isDarkMode(context),
                onChanged: (value) {
                  widget.toggleDarkMode();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'Language: ',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 16),
              DropdownButton(
                value: _language(context),
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
                  widget.changeLanguage(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  String _language(BuildContext context) {
    // this should be implemented with a localization package or similar
    // for simplicity, we will return 'English'
    return 'English';
  }
}